require_relative 'piece'

class Rook < Piece
	def initialize team
		@move_steps = STRAIGHT_STEPS
		@capture_steps = STRAIGHT_STEPS
		@piece_char = "R"
		super
	end
end
