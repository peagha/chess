class BoardRender
	def self.render_piece piece
		piece.team == :black ? "*K" : "K"
	end
end
