require 'minitest/autorun'
require_relative 'board'

class MoveHistoryTest < MiniTest::Test
	def setup
		@board = Board.new.setup
	end

	def test_one_move_history
		@board.move "a2", "a3"
		assert_equal [["a3"]], @board.move_history
	end

	def test_two_moves_history
		@board.move "a2", "a3"
		@board.move "a7", "a6"
		assert_equal [["a3","a6"]], @board.move_history
	end

	def test_horse_move_history
		@board.move "g1", "f3"
		assert_equal [["Kf3"]], @board.move_history
	end
end
