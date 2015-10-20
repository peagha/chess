require 'set'
require_relative "rook"
require_relative "pawn"
require_relative "horse"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "chesserror"
require_relative "boardsetup"

class Board

	attr_accessor :white_count, :black_count

	RANK_RANGE = ?1..?8
	FILE_RANGE = ?a..?h

	def initialize pieces = nil
		@pieces = {}
		pieces.each do |square, piece|
			self[square.to_s] = piece
		end if pieces
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
		@pieces[square.to_s] 
	end

	def []= square, piece 
		@pieces[square.to_s] = piece
	end

	def move from, to
		raise IlegalMoveError if !is_legal_move(from, to)

		self[to] = self[from]
		self[from] = nil
	end

	def is_legal_move from, to
		move_list(from).include?(to)
	end
	
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
	
	def add_square_range_to_set set, start_square, file_step, rank_step, limit = nil 
		step_square(start_square, 
			    file_step, 
			    rank_step).each_with_index do |next_square, index|
			break if self[next_square]
			break if limit && limit <= index 
			set.add next_square
		end
	end
	private :add_square_range_to_set

	def capture_list square
		piece = self[square]
		capture_list = Set.new
		
		piece.capture_steps.each do |move_step| 
			add_capture_range_to_set capture_list, square, *move_step, piece.move_limit
		end
		capture_list
	end
	
	def add_capture_range_to_set set, start_square, file_step, rank_step, limit = nil 
		step_square(start_square, 
			    file_step, 
			    rank_step).each_with_index do |next_square, index|
			break if limit && limit <= index 
			if self[next_square]
				set.add next_square
				break
			end
		end
	end
	private :add_capture_range_to_set

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

	def setup
		BoardSetup.new(self).load_default
	end
end
