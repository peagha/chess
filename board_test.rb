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

	def test_board_hash_setup
		board = Board.new({ 
			"a1" => Pawn.white, 
			"a2" => Pawn.black, 
			"a3" => Pawn.white })
		assert_equal Pawn.white, board["a1"]
		assert_equal Pawn.black, board["a2"]
		assert_equal Pawn.white, board["a3"]
	end
	
	def test_symbol_square
		board = Board.new({
			"a1" => Pawn.white,
			:a2 => Pawn.white })
		board[:a3] = Pawn.white
		assert_equal Pawn.white, board["a1"]
		assert_equal Pawn.white, board["a2"]
		assert_equal Pawn.white, board["a3"]
		assert_equal Pawn.white, board[:a1]
	end

end
