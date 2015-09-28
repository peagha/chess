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

	FIRST_RANK = ?1
	LAST_RANK = ?8
	FIRST_FILE = ?a
	LAST_FILE = ?h

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

	def move_list square
		message = "Can't list possible moves on empty square"  
		raise EmptySquareError, message if self[square].nil? 

		file = square[0]
		rank = square[1]
		piece = self[square]

		if piece.class == Pawn
			direction = piece.team == :white ? 1 : -1
			next_coord = file + (rank.ord + direction).chr

			if rank < LAST_RANK && self[next_coord].nil?
				return Set.new [next_coord]
			else
				return Set.new
			end
		else
			move_list = Set.new
			rank.next.upto(LAST_RANK).each do |next_rank|
				next_square = file + next_rank
				break unless self[next_square].nil?
				move_list.add next_square
			end

			rank.ord.pred.downto(FIRST_RANK.ord) do |prev_rank|
				prev_square = file + prev_rank.chr
				break unless self[prev_square].nil?
				move_list.add prev_square
			end

			file.next.upto(LAST_FILE).each do |next_file|
				next_square = next_file + rank
				break unless self[next_square].nil?
				move_list.add next_square
			end

			file.ord.pred.downto(FIRST_FILE.ord) do |prev_file|
				prev_square = prev_file.chr + rank
				break unless self[prev_square].nil?
				move_list.add prev_square
			end

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
