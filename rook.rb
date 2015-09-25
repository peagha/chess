class Rook

	private
	def initialize team = nil
		@team = team
	end

	public
	attr_reader :team

	def self.white
		Pawn.new :white
	end

end
