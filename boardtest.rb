require 'minitest/autorun'
require_relative 'board'

class BoardTest < MiniTest::Test

	def test_board_setup
		board = Board.new
		board.setup
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
		board["a1"] = Pawn.new
		assert_equal 1, board.piece_count
	end

	def test_piece_retrieval
		board = Board.new
		board.setup
		piece = board["a1"]
		assert_instance_of Rook, piece
	end

	def test_piece_move
		board = Board.new
		board.setup
		assert_nil board["a3"]
		board.move "a2", "a3"
		refute_nil board["a3"]
	end

	def test_piece_color
		board = Board.new
		board.setup
		piece = board["a1"]
		assert_equal :white, piece.color
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
end
