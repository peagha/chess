class Pawn
	private
	def initialize team = nil
		@team = team
	end

	public
	attr_reader :team

	def self.white
		Pawn.new :white
	end

	def self.black
		Pawn.new :black
	end

end
