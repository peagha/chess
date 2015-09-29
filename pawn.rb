require_relative 'piece'

class Pawn < Piece
	def initialize team
		@move_limit = 1
		super
	end
end
