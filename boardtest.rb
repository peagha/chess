require 'minitest/autorun'
require 'set'
require_relative 'board'

class BoardTest < MiniTest::Test

	def test_board_setup
		board = Board.new.setup
		assert_equal 32, board.piece_count
		[1,2,7,8].each do |rank|
			('a'..'h').each do |file|
				square = file + rank.to_s
				refute_nil board[square], "#{square} should have a piece"
			end
		end
	end

	def test_set_piece
		board = Board.empty
		board["a1"] = Pawn.white
		assert_equal 1, board.piece_count
	end

	def test_piece_retrieval
		board = Board.new.setup
		piece = board["a1"]
		assert_instance_of Rook, piece
	end

	def test_piece_move
		board = Board.new.setup
		assert_nil board["a3"]
		board.move "a2", "a3"
		refute_nil board["a3"]
	end

	def test_empty_board
		board = Board.empty
		assert_equal 0, board.piece_count
		assert_equal 0, board.white_count
		assert_equal 0, board.black_count

		(1..8).each do |rank|
			('a'..'h').each do |file|
				square = file + rank.to_s
				assert_nil board[square], "#{square} should be empty"
			end
		end
	end

	def test_setup_return_self
		board = Board.new
		assert_equal board, board.setup
	end

	def test_piece_team
		[Pawn, Rook, Bishop, King, Queen, Horse].each do |piece_class|
			white_piece = piece_class.white
			assert_equal :white, white_piece.team
		
			black_piece = piece_class.black
			assert_equal :black, black_piece.team
		end
	end
	
	def test_piece_count
		board = Board.empty
		assert_equal 0, board.black_count
		assert_equal 0, board.white_count
		assert_equal 0, board.piece_count

		board["a2"] = Pawn.white
		board["a7"] = Pawn.black
		board["b7"] = Pawn.black

		assert_equal 3, board.piece_count
		assert_equal 1, board.white_count
		assert_equal 2, board.black_count
	end

	def test_pawn_move_list_board_limit
		board = Board.empty
		board["a8"] = Pawn.white

		move_list = board.move_list "a8"
		assert_equal Set.new, move_list
	end

	def test_pawn_move_list_ocupied_square
		board = Board.empty
		board["a6"] = Pawn.black
		board["a5"] = Pawn.white
	
		move_list = board.move_list "a5"
		assert_equal Set.new, move_list
	end

	def test_empty_square_move_list
		board = Board.empty
		assert_raises(EmptySquareError) do
			board.move_list "a1"
		end
	end

	def test_piece_move_list
		hash = { Horse.black => %w{ c3 b4 b6 c7 e7 f6 f4 e3 },
			 Queen.white => %w{ a5 b5 c5 e5 f5 g5 h5 
				            d1 d2 d3 d4 d6 d7 d8 
					    e6 f7 g8 
					    c6 b7 a8 
				       	    c4 b3 a2 
				       	    e4 f3 g2 h1 },
			 King.white => %w{ e4 e5 e6 d4 d6 c4 c5 c6 },
			 Bishop.black => %w{ a8 b7 c6 e4 f3 g2 h1 a2 b3 c4 e6 f7 g8 },
			 Rook.black => %w{ a5 b5 c5 e5 f5 g5 h5 d1 d2 d3 d4 d6 d7 d8 },
			 Pawn.black => ["d4"],
			 Pawn.white => ["d6"]}

		hash.each do |piece, expected|
			board = Board.empty
			board["d5"] = piece 
			assert_equal Set.new(expected), board.move_list("d5"), "#{piece.class}" 
		end
	end

	def test_pawn_capture_list
		board = Board.empty
		board["b2"] = Pawn.white
	
		board["c3"] = Pawn.black
		board["a3"] = Pawn.black

		assert_equal Set.new(["c3", "a3"]), board.capture_list("b2")
	end
	
	def test_bishop_capture_list
		board = Board.empty
		board["d5"] = Bishop.white
	
		board["a8"] = Pawn.black
		board["a2"] = Pawn.black
		board["g8"] = Pawn.black
		board["h1"] = Pawn.black

		assert_equal Set.new( %w{ a8 a2 g8 h1 }), board.capture_list("d5")
	end

	#def test_board_hash_setup
	#	board = Board.new({ "a1" => Pawn.white, "a2" => Pawn.black, "a3" => Pawn.white })
	#	assert_equal Pawn.white, board["a1"]
	#	assert_equal Pawn.black, board["a2"]
	#	assert_equal Pawn.white, board["a3"]
	#end
	
	def test_piece_equality
		assert_equal Pawn.white, Pawn.white
		refute_equal Pawn.black, Pawn.white
		refute_equal King.black, Queen.black
		refute_equal King.black, nil 
	end
end
