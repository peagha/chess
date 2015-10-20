require_relative 'board'

class BoardSetup

	def self.create_default
		self.new.load_default
	end

	def initialize board = Board.new
		@board = board
	end

	def load_default
		setup_pawns()
		setup_all_except_pawn()
		@board
	end

	def setup_pawns
		{?2 => :white, 
		 ?7 => :black}.each do |rank, team|
			('a'..'h').each do |file|
				square = file + rank
				@board[square] = Pawn.new(team)
			end
		end
	end
	private :setup_pawns

	def setup_all_except_pawn
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
				@board[square] = piece_class.new(team)
			end
		end
	end
	private :setup_all_except_pawn
end
