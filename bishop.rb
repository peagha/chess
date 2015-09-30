require_relative 'piece'

class Bishop < Piece 
	def initialize team
		@move_steps = DIAGONAL_STEPS
		super
	end
end
