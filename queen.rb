require_relative 'piece'

class Queen < Piece 
	def initialize team
		@move_steps = STRAIGHT_STEPS + DIAGONAL_STEPS
		@piece_char = "Q"
		super
	end
end
