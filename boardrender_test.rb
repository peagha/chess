require 'minitest/autorun'
require_relative 'board'
require_relative 'boardrender'

class BoardRenderTest < MiniTest::Test
	def test_render_piece
		piece_render = { 
			King => ?K,
			Queen => ?Q,
			Horse => ?N,
			Bishop => ?B,
			Rook => ?R,
			Pawn => ?P }
		piece_render.each do |piece, render|
			result = BoardRender.render_piece(piece.white)
			assert_equal render, result
		end

		assert_equal "*K", BoardRender.render_piece(King.black)
	end
end
