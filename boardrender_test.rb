require 'minitest/autorun'
require_relative 'board'
require_relative 'boardrender'

class BoardRenderTest < MiniTest::Test
	def test_render_piece
		assert_equal "K", BoardRender.render_piece(King.white)
		assert_equal "*K", BoardRender.render_piece(King.black)
	end
end
