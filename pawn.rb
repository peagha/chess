require_relative 'piece'

class Pawn < Piece
	def initialize team
		@move_limit = 1
		@move_steps = team == :white ? [UP] : [DOWN]
		@capture_steps = [[1,1],[-1,1]]
		super
	end
end
