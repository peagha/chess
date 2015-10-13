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

	def test_render_empty
		expected_row = "|*R |   |   |   |   |   |   | Q |"
		board = Board.new({a1: Rook.black, h1: Queen.white})
		renderer = BoardRender.new board
		assert_equal expected_row, renderer.render_rank(?1)
	end

	def test_render_board
		expected = 
			"|*R |*N |*B |*Q |*K |*B |*N |*R |\n" +
			"---------------------------------\n" +
			"|*P |*P |*P |*P |*P |*P |*P |*P |\n" +
			"---------------------------------\n" +
			"|   |   |   |   |   |   |   |   |\n" +
			"---------------------------------\n" +
			"|   |   |   |   |   |   |   |   |\n" +
			"---------------------------------\n" +
			"|   |   |   |   |   |   |   |   |\n" +
			"---------------------------------\n" +
			"|   |   |   |   |   |   |   |   |\n" +
			"---------------------------------\n" +
			"| P | P | P | P | P | P | P | P |\n" +
			"---------------------------------\n" +
			"| R | N | B | Q | K | B | N | R |\n"
		board = Board.new.setup
		renderer = BoardRender.new board
		assert_equal expected, renderer.render
	end
		
end
