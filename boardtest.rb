require 'minitest/autorun'
require 'set'
require_relative 'board'

class BoardTest < MiniTest::Test

	def test_board_setup
		board = Board.new.setup
		assert_equal 32, board.piece_count
		[1,2,7,8].each do |rank|
			('a'..'h').each do |file|
				coordinate = file + rank.to_s
				refute_nil board[coordinate], "#{coordinate} should have a piece"
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
				coordinate = file + rank.to_s
				assert_nil board[coordinate], "#{coordinate} should be empty"
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

	def test_move_list
		board = Board.empty
		board["a2"] = Pawn.white
		
		move_list = board.move_list "a2"
		assert_equal Set.new(["a3"]), move_list
	end

	def test_move_list_board_limit
		board = Board.empty
		board["a8"] = Pawn.white

		move_list = board.move_list "a8"
		assert_equal Set.new, move_list
	end
end
