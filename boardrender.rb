class BoardRender
	def initialize board
		@board = board
	end

	def render_rank rank
		output = "|"
		Board::FILE_RANGE.each do |file|
			square = file + rank
			render = self.class.render_piece(@board[square])
			output += render + " |"
		end
		output
	end

	def self.render_piece piece
		return "  " if piece.nil?

		piece.team == :black ? 
			"*" + piece.piece_char :
			piece.piece_char
	end
end
