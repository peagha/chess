require_relative "rook"
require_relative "pawn"

class Board

	attr_accessor :white_count, :black_count

	def initialize
		@pieces = {}
		@black_count = 0
		@white_count = 0
	end

	def piece_count
		@pieces.count
	end

	def setup
		@pieces["a1"] = Rook.new
		@pieces["a2"] = Pawn.new
	end

	def [] coordinate
		@pieces[coordinate] 
	end

	def []= coordinate, value
		@pieces[coordinate] = value
	end

	def move from, to
		@pieces[to] = @pieces[from]
		@pieces[from] = nil
	end

	def self.empty
		Board.new
	end
end
