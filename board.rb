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


	def step_square start_square, file_step, rank_step
		next_file = start_square[0].ord + file_step
		next_rank = start_square[1].ord + rank_step
		next_square = next_file.chr + next_rank.chr
		
		Enumerator.new do |y|
			while RANK_RANGE.member?(next_rank.chr) && 
			      FILE_RANGE.member?(next_file.chr)
				y << next_square
				next_file += file_step
				next_rank += rank_step
				next_square = next_file.chr + next_rank.chr
			end
		end
	end
	private :step_square
	
	def add_square_range_to_set set, start_square, file_step, rank_step, limit = nil 
		step_square(start_square, 
			    file_step, 
			    rank_step).each_with_index do |next_square, index|
			break if @pieces[next_square]
			break if limit && limit <= index 
			set.add next_square
		end
	end
	private :add_square_range_to_set

	def move_list square
		message = "Can't list possible moves on empty square"  
		raise EmptySquareError, message if self[square].nil? 

		piece = self[square]
		move_list = Set.new
		piece.move_steps.each do |move_step| 
			add_square_range_to_set move_list, square, *move_step, piece.move_limit
		end
		move_list
	end

	def capture_list square
		piece = self[square]
		capture_list = Set.new
		[[1,1],[-1,1]].each do |move_step| 
			add_capture_range_to_set capture_list, square, *move_step, piece.move_limit
		end
		capture_list
	end
	
	def add_capture_range_to_set set, start_square, file_step, rank_step, limit = nil 
		step_square(start_square, 
			    file_step, 
			    rank_step).each_with_index do |next_square, index|
			break if limit && limit <= index 
			if @pieces[next_square]
				set.add next_square
				break
			end
		end
	end
	
	private :add_square_range_to_set

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
