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

	RANK_RANGE = ?1..?8
	FILE_RANGE = ?a..?h

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
	
	def [] square
		@pieces[square] 
	end

	def []= square, piece 
		@pieces[square] = piece
	end

	def move from, to
		@pieces[to] = @pieces[from]
		@pieces[from] = nil
	end

	def add_square_range_to_set set, start_square, file_step, rank_step
		start_file = start_square[0].ord
		start_rank = start_square[1].ord

		next_file = start_file + file_step
		next_rank = start_rank + rank_step
		next_square = next_file.chr + next_rank.chr
	
		while RANK_RANGE.member?(next_rank.chr) && 
		      FILE_RANGE.member?(next_file.chr) &&
		      self[next_square].nil?

			set.add next_square
			next_file += file_step
			next_rank += rank_step
			next_square = next_file.chr + next_rank.chr
		end
	end
	private :add_square_range_to_set

	def move_list square
		message = "Can't list possible moves on empty square"  
		raise EmptySquareError, message if self[square].nil? 

		file = square[0]
		rank = square[1]
		piece = self[square]

		if piece.class == Pawn
			direction = piece.team == :white ? 1 : -1
			next_coord = file + (rank.ord + direction).chr

			if rank < RANK_RANGE.last&& self[next_coord].nil?
				return Set.new [next_coord]
			else
				return Set.new
			end
		else
			move_list = Set.new
			add_square_range_to_set move_list, square, -1, 0
			add_square_range_to_set move_list, square, 1, 0
			add_square_range_to_set move_list, square, 0, 1
			add_square_range_to_set move_list, square, 0, -1
			return move_list
		end
	end

	def setup

		{?2 => :white, 
		 ?7 => :black}.each do |rank, team|
			('a'..'h').each do |file|
				square = file + rank
				@pieces[square] = Pawn.new(team)
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
				square = file + rank
				@pieces[square] = piece_class.new(team)
			end
		end

		self
	end

end
