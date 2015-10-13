require 'minitest/autorun'
require_relative 'board'
require_relative 'boardrender'

class BoardRenderTest < MiniTest::Test
	def test_render_piece
		rendered = BoardRender.render_piece King.white
		assert_equal "K", rendered
	end
end
