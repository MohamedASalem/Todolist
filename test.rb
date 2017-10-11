puts ARGV.inspect
ARGV.each do|a|
	puts "Argument : #{a}"
end
class task 
	attr_accessor :name , :category, :priority
	def initialize(name)
		self.name=name
		self.category=general
		self.priority=
	end