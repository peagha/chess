class Pawn
	private
	def initialize color = nil
		@color = color
	end

	public
	attr_reader :color

	def self.white
		Pawn.new :white
	end

end
