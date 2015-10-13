class BoardRender
	def self.render_piece piece
		piece_char = ?K
		piece.team == :black ? 
			"*" + piece_char :
			piece_char
	end
end
