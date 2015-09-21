require_relative "rook"
require_relative "pawn"

class Board

	attr_accessor :piece_count, :white_count, :black_count

	def initialize
		@piece_count = 32
		@black_count = 16
		@white_count = 16

		@pieces = {}
	end

	def setup
		@pieces["a1"] = Rook.new
		@pieces["a2"] = Pawn.new
	end

	def [] coordinate
		@pieces[coordinate] 
	end

	def move from, to
		@pieces[to] = @pieces[from]
		@pieces[from] = nil
	end

	def self.empty
		Board.new
	end
end
