class BoardRender
	def self.render_piece piece
		piece_render = { 
			King => ?K,
			Queen => ?Q,
			Horse => ?N,
			Bishop => ?B,
			Rook => ?R,
			Pawn => ?P }
		piece_char = piece_render[piece.class]

		piece.team == :black ? 
			"*" + piece_char :
			piece_char
	end
end
