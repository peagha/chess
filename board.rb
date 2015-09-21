require_relative "rook"
require_relative "pawn"
require_relative "horse"
require_relative "bishop"
require_relative "queen"
require_relative "king"

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
		[2,7].each do |rank|
			('a'..'h').each do |file|
				coordinate = file + rank.to_s
				@pieces[coordinate] = Pawn.new
			end
		end
		
		["a1", "h1", "a8", "h8"].each do |coordinate|
			@pieces[coordinate] = Rook.new
		end

		["b1", "g1", "b8", "g8"].each do |coordinate|
			@pieces[coordinate] = Horse.new
		end

		["c1", "f1", "c8", "f8"].each do |coordinate|
			@pieces[coordinate] = Bishop.new
		end

		@pieces["d8"] = Queen.new
		@pieces["d1"] = Queen.new
		@pieces["e8"] = King.new
		@pieces["e1"] = King.new

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
