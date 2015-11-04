require 'set'
require_relative "rook"
require_relative "pawn"
require_relative "horse"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "chesserror"
require_relative "boardsetup"
require_relative "square"

class Board

	attr_accessor :white_count, :black_count

	RANK_RANGE = ?1..?8
	FILE_RANGE = ?a..?h

	def initialize pieces = nil
		@pieces = {}
		pieces.each do |square, piece|
			self[square] = piece
		end if pieces
		@move_history = []
	end

	def self.empty
		Board.new
	end

	def empty_square? square
		self[square].nil?
	end

	def has_piece? square
		!empty_square? square
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
		Square === square ?
			@pieces[square] :
			@pieces[Square.new(square)]
	end

	def []= square, piece 
		square_object = Square === square ?
			square :
			Square.new(square)

		@pieces[square_object] = piece
	end

	def move from, to
		raise IlegalMoveError if !is_legal_move(from, to)

		self[to] = self[from]
		self[from] = nil

		@move_history << to
	end

	def is_legal_move from, to
		move_list(from).include?(to)
	end
	
	def move_list square
		message = "Can't list possible moves on empty square"  
		raise EmptySquareError, message if empty_square?(square) 

		piece = self[square]
		move_list = Set.new
		piece.move_steps.each do |move_step| 
			move_range = get_empty_squares square, *move_step, piece.move_limit
			move_list.merge move_range
		end
		move_list.map! {|square| square.coordinate}
	end
	
	def get_empty_squares  start_square, file_step, rank_step, limit = nil 
		step_square(start_square, file_step, rank_step, limit)
			.take_while {|square| empty_square?(square) }
	end
	private :get_empty_squares

	def capture_list square
		piece = self[square]
		capture_list = Set.new
		
		piece.capture_steps.each do |move_step| 
			next_capture = find_next_capture square, *move_step, piece.move_limit
			capture_list.add(next_capture) if next_capture
		end
		capture_list.map! {|square| square.coordinate} 
	end
	
	def find_next_capture start_square, file_step, rank_step, limit  
		step_square(start_square, file_step, rank_step, limit)
			.find { |square| has_piece?(square) }
	end
	private :find_next_capture

	def step_square start_square, file_step, rank_step, limit = nil
		Square.new(start_square)
			.each_with_step(file_step, rank_step, limit)
			.take_while {|square| within_board? square}
	end
	private :step_square

	def within_board? square
		RANK_RANGE.member?(square.rank) && 
		FILE_RANGE.member?(square.file)
	end

	def setup
		BoardSetup.new(self).load_default
	end

	def move_history
		@move_history
	end
end
