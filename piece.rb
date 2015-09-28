class Piece

	private
	def initialize team
		@team = team
	end

	public
	attr_reader :team

	def self.white
		self.new :white
	end

	def self.black
		self.new :black
	end

end
