class BoardRender
	def initialize board
	end

	def render_rank rank
		output = ""
		Board::FILE_RANGE.each do
			output += "|   "
		end
		output += "|"
	end

	def self.render_piece piece
		piece.team == :black ? 
			"*" + piece.piece_char :
			piece.piece_char
	end
end
