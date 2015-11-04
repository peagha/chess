require 'minitest/autorun'
require 'set'
require_relative 'board'

class CaptureTest < MiniTest::Test

	def test_pawn_capture_list
		board = Board.new({
			"b2" => Pawn.white,
			"c3" => Pawn.black,
			"a3" => Pawn.black })

		assert_equal Set.new(["c3", "a3"]), board.capture_list("b2")
	end

	def test_pawn_capture_list_with_limit
		board = Board.new({
			"b2" => Pawn.white,
			"d4" => Pawn.black,
			"a3" => Pawn.black })

		assert_equal Set.new(["a3"]), board.capture_list("b2")
	end

	def test_bishop_capture_list
		board = Board.new({
			"d5" => Bishop.white,
			"a8" => Pawn.black,
			"a2" => Pawn.black,
			"g8" => Pawn.black,
			"h1" => Pawn.black }) 

		assert_equal Set.new( %w{ a8 a2 g8 h1 }), board.capture_list("d5")
	end

	def test_rook_capture_list
		board = Board.new({
			d5: Rook.black,
			d8: Pawn.white,
			d1: Pawn.white,
			a5: Pawn.white,
			h5: Pawn.white })
		assert_equal Set.new( %w{ d8 d1 a5 h5 }), board.capture_list("d5")
	end
end
