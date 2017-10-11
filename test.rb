puts ARGV.inspect
ARGV.each do|a|
	puts "Argument : #{a}"
end
$general=0
Tasks=Array.new
class Task 
	attr_accessor :name , :category, :priority
	def initialize(name)
		self.name=name
		self.category="general"
		self.priority=$general
	end
end
if(ARGV[0].eql?"add")
	Tasks[$general]=Task.new(ARGV[1].chomp.to_s)
	puts Tasks[$general].name + Tasks[$general].category
	puts $general
	$general+=1
elsif(ARGV[0].eql?"list")
	puts "Terminal To-do List\n1-Add(Taskname) \#CategoryName(Optional)"
end