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
end
