require 'set'
require_relative "rook"
require_relative "pawn"
require_relative "horse"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "chesserror"

class Board

	attr_accessor :white_count, :black_count

	def initialize
		@pieces = {}
	end

	def self.empty
		Board.new
	end
	
	def piece_count
		@pieces.count
	end

	def white_count
		team_count :white	
	end
	
	def black_count
		team_count :black
	end
	
	def team_count team
		@pieces.count {|position, piece| piece.team == team}
	end
	private :team_count
	
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

	def move_list coordinate
		message = "Can't list possible moves on empty square"  
		raise EmptySquareError, message if self[coordinate].nil? 

		file = coordinate[0]
		rank = coordinate[1]

		piece = self[coordinate]
		direction = piece.team == :white ? 1 : -1
		next_coord = file + (rank.ord + direction).chr

		if rank < ?8 && self[next_coord].nil?
			Set.new [next_coord]
		else
			Set.new
		end
	end

	def setup

		{?2 => :white, 
		 ?7 => :black}.each do |rank, team|
			('a'..'h').each do |file|
				coordinate = file + rank
				@pieces[coordinate] = Pawn.new(team)
			end
		end

		files = {?a => Rook,
			 ?b => Horse,
			 ?c => Bishop,
			 ?d => Queen,
			 ?e => King,
			 ?f => Bishop,
			 ?g => Horse,
			 ?h => Rook }

		{?1 => :white, 
		 ?8 => :black}.each do |rank, team|
			files.each do |file, piece_class|
				coordinate = file + rank
				@pieces[coordinate] = piece_class.new(team)
			end
		end

		self
	end

end
