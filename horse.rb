require_relative 'piece'

class Horse < Piece 
	def initialize team
		@move_limit = 1
		@move_steps = [[2,1],[1,2],[-2,1],[-1,2],[2,-1],[1,-2],[-2,-1],[-1,-2]]
		super
	end
end
