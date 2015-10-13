require 'minitest/autorun'
require_relative 'board'
require_relative 'boardrender'

class BoardRenderTest < MiniTest::Test

	def test_render_empty_rank
		expected_row = "|   |   |   |   |   |   |   |   |"
		board = Board.empty
		renderer = BoardRender.new board
		assert_equal expected_row, renderer.render_rank(?1)
	end

	def test_render_empty_rank
		expected_row = "|*R |   |   |   |   |   |   |   |"
		board = Board.new({a1: Rook.black})
		renderer = BoardRender.new board
		assert_equal expected_row, renderer.render_rank(?1)
	end
end
