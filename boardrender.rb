class BoardRender
	def initialize board
		@board = board
	end

	def render_rank rank
		output = "|"
		Board::FILE_RANGE.each do |file|
			square = file + rank
			render = render_square square 
			output += render + " |"
		end
		output
	end

	def render_square square
		piece = @board[square]
		return "  " if piece.nil?
		prefix = piece.team == :black ? "*" : " " 
		prefix + piece.piece_char
	end
end
