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
		piece_render.each do |piece, piece_char|
			assert_equal piece_char, BoardRender.render_piece(piece.white)
			assert_equal ?* + piece_char, BoardRender.render_piece(piece.black)
		end
	end
end
