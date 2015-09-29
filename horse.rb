require_relative 'piece'

class Horse < Piece 
	def initialize team
		@move_limit = 1
		super
	end
end
