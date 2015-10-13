require_relative 'piece'

class Bishop < Piece 
	def initialize team
		@capture_steps = DIAGONAL_STEPS
		@move_steps = DIAGONAL_STEPS
		@piece_char = "B"
		super
	end
end
