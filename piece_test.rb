require 'minitest/autorun'
require_relative 'board'

class PieceTest < MiniTest::Test
	
	def test_piece_team
		[Pawn, Rook, Bishop, King, Queen, Horse].each do |piece_class|
			white_piece = piece_class.white
			assert_equal :white, white_piece.team
		
			black_piece = piece_class.black
			assert_equal :black, black_piece.team
		end
	end
	
	def test_piece_equality
		assert_equal Pawn.white, Pawn.white
		refute_equal Pawn.black, Pawn.white
		refute_equal King.black, Queen.black
		refute_equal King.black, nil 
	end

end

