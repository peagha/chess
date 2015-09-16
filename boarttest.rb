require 'minitest/autorun'
require_relative 'board'

class BoardTest < MiniTest::Test

	def test_board_initialization
		board = Board.new
		assert_equal 32, board.piece_count
	end

end
