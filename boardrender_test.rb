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
