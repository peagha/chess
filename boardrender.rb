class BoardRender
	def self.render_piece piece
		piece.team == :black ? 
			"*" + piece.piece_char :
			piece.piece_char
	end
end
