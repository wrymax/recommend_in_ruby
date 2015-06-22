module Helpers
	def sum(array)
		array.inject(0) do |ret, i|
			ret += i.to_i
		end
	end
end
