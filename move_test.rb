require 'minitest/autorun'
require 'set'
require_relative 'board'

class MoveTest < MiniTest::Test

	def test_piece_move
		board = Board.new.setup
		assert_nil board["a3"]
		board.move "a2", "a3"
		refute_nil board["a3"]
	end

	def test_piece_move_empty_square
		board = Board.empty
		assert_raises EmptySquareError do
			board.move "a1", "a2"
		end
	end

	def test_piece_ilegal_move
		board = Board.new.setup
		assert_raises IlegalMoveError do
			board.move "a2", "e3"
		end
	end

	def test_pawn_move_list_board_limit
		board = Board.empty
		board["a8"] = Pawn.white

		move_list = board.move_list "a8"
		assert_equal Set.new, move_list
	end

	def test_pawn_move_list_ocupied_square
		board = Board.empty
		board["a6"] = Pawn.black
		board["a5"] = Pawn.white
	
		move_list = board.move_list "a5"
		assert_equal Set.new, move_list
	end

	def test_empty_square_move_list
		board = Board.empty
		assert_raises(EmptySquareError) do
			board.move_list "a1"
		end
	end

	def test_piece_move_list
		hash = { Horse.black => %w{ c3 b4 b6 c7 e7 f6 f4 e3 },
			 Queen.white => %w{ a5 b5 c5 e5 f5 g5 h5 
				            d1 d2 d3 d4 d6 d7 d8 
					    e6 f7 g8 
					    c6 b7 a8 
				       	    c4 b3 a2 
				       	    e4 f3 g2 h1 },
			 King.white => %w{ e4 e5 e6 d4 d6 c4 c5 c6 },
			 Bishop.black => %w{ a8 b7 c6 e4 f3 g2 h1 a2 b3 c4 e6 f7 g8 },
			 Rook.black => %w{ a5 b5 c5 e5 f5 g5 h5 d1 d2 d3 d4 d6 d7 d8 },
			 Pawn.black => ["d4"],
			 Pawn.white => ["d6"]}

		hash.each do |piece, expected|
			board = Board.empty
			board["d5"] = piece 
			assert_equal Set.new(expected), board.move_list("d5"), "#{piece.class}" 
		end
	end

end
