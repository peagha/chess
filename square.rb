class Square

	attr_reader :file, :rank

	def initialize coordinate
		@file = coordinate[0]
		@rank = coordinate[1]
	end

	def == other
		if other.respond_to?(:coordinate)
			self.coordinate == other.coordinate
		end
	end
	alias :eql? :==

	def coordinate
		@file + @rank
	end
	
	def hash
		coordinate.hash
	end

	def step file_step, rank_step
		new_file = step_char @file, file_step
		new_rank = step_char @rank, rank_step
		Square.new new_file + new_rank
	end

	def step_char char, step
		(char.ord + step).chr
	end
	private :step_char

	def each_with_step file_step, rank_step
		next_square = self
		Enumerator.new do |y|
			while true
				next_square = next_square.step(file_step, rank_step)
				y <<  next_square
			end
		end
	end
end
