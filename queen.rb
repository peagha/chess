require_relative 'piece'

class Queen < Piece 
	def initialize team
		@move_steps = STRAIGHT_STEPS + DIAGONAL_STEPS
		super
	end
end
