require_relative 'piece'

class King < Piece 
	def initialize team
		@move_limit = 1
		super
	end
end
