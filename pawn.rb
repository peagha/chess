require_relative 'piece'

class Pawn < Piece
	def initialize team
		@move_limit = 1
		@move_steps = team == :white ? [UP] : [DOWN]
		super
	end
end
