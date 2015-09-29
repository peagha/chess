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

	def add_square_range_to_set set, start_square, file_step, rank_step, limit = nil 
		next_file = start_square[0].ord + file_step
		next_rank = start_square[1].ord + rank_step
		next_square = next_file.chr + next_rank.chr
	
		count = 0
		while RANK_RANGE.member?(next_rank.chr) && 
		      FILE_RANGE.member?(next_file.chr) &&
		      self[next_square].nil?

			set.add next_square
			next_file += file_step
			next_rank += rank_step
			next_square = next_file.chr + next_rank.chr

			break if limit && (count += 1) <= limit
		end
	end
	private :add_square_range_to_set

	def move_list square
		message = "Can't list possible moves on empty square"  
		raise EmptySquareError, message if self[square].nil? 

		piece = self[square]

		case piece
		when Pawn
			rank_step = piece.team == :white ? 1 : -1
			parameter_list = [[0, rank_step, 1]]
		when Rook; parameter_list = [[-1,0],[1,0],[0,1],[0,-1]]
		when Bishop; parameter_list = [[-1,-1],[1,1],[-1,1],[1,-1]]
		end

		move_list = Set.new
		parameter_list.each do |p| 
			add_square_range_to_set move_list, square, *p
		end
		move_list
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
