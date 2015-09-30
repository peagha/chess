require_relative 'piece'

class Rook < Piece
	def initialize team
		@move_steps = STRAIGHT_STEPS
		super
	end
end
