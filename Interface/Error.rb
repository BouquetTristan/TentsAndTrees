require "Label.rb"

class Error

	def Error(text)
		new(text)
	end

	def initialize(text)
		error = Label.new(text, "EF2929", "15")
	end
end