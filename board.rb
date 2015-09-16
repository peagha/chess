class Board

	attr_accessor :piece_count, :white_count, :black_count

	def initialize
		@piece_count = 32
		@black_count = 16
		@white_count = 16
	end
end
