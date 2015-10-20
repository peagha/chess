require 'minitest/autorun'
require_relative 'square'

class SquareTest < MiniTest::Test
	def test_square_equal
		assert_equal Square.new("a1"), Square.new(:a1)
	end
	
	def test_square_file_and_rank
		square = Square.new :a1
		assert_equal ?1, square.rank
		assert_equal ?a, square.file
	end
end
