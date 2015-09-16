require 'minitest/autorun'
require_relative 'board'

class BoardTest < MiniTest::Test

	def test_board_initialization
		board = Board.new
		assert_equal 32, board.piece_count
		assert_equal 16, board.white_count
		assert_equal 16, board.black_count
	end

	def test_piece_retrieval
		board = Board.new
		piece = board["a1"]
		assert_instance_of Rook, piece
	end

	def test_piece_move
		board = Board.new
		assert_nil board["a3"]
		board.move "a2", "a3"
		refute_nil board["a3"]
	end

end
