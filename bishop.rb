require_relative 'piece'

class Bishop < Piece 
	def initialize team
		@capture_steps = DIAGONAL_STEPS
		@move_steps = DIAGONAL_STEPS
		super
	end
end
