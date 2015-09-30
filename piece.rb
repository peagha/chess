class Piece
	UP = [0,1]
	DOWN = [0,-1]
	LEFT = [-1,0]
	RIGHT = [1,0]
	STRAIGHT_STEPS = [UP, DOWN, LEFT, RIGHT]
		
	LEFT_UP = [-1,1]
	RIGHT_UP = [1,1]
	LEFT_DOWN = [-1,-1]
	RIGHT_DOWN = [1,-1]
	DIAGONAL_STEPS = [LEFT_UP, RIGHT_UP, LEFT_DOWN, RIGHT_DOWN]

	private
	def initialize team
		@team = team
	end

	public
	attr_reader :team, :move_limit, :move_steps

	def self.white
		self.new :white
	end

	def self.black
		self.new :black
	end

end
