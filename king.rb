require_relative 'piece'

class King < Piece 
	def initialize team
		@move_limit = 1
		@move_steps = STRAIGHT_STEPS + DIAGONAL_STEPS
		@piece_char = "K"
		super
	end
end
