require 'json'
require 'active_support/json'

puts ARGV.inspect
ARGV.each do|a|
  puts "Argument : #{a}"
end
flag=0
tasks=Array.new
temp=""
cat=""
class Task
  attr_accessor :name , :category, :priority
  def initialize(name, category = nil, priority = nil)
    self.name = name
    self.category = category || "general"
    self.priority = priority || $general.to_s
  end
end

f1=File.read('demo.json')
data=JSON.parse(f1).to_a
tasks =data.map { |tsk| Task.new(tsk['name'], tsk['category'],tsk['priority'])}
$general =(tasks[tasks.size-1].priority.to_i)+1

if(ARGV[0].eql?"add")
	ARGV.each_with_index do |arg,i|
		if(i==0 or ARGV[i].include? "\#")
  		#puts"no"
  		if(ARGV[i].include? "\#")
  		cat=ARGV[i]
  		puts ARGV[i]
  	end
  	else
  		temp << ARGV[i].chomp.to_s + " "
		end
	end
	tasks << Task.new(temp)
	puts tasks[$general]
	tasks[$general-1].category=cat
	$general += 1

elsif(ARGV[0].eql?"help")
  puts "Terminal To-do List\n1-Add(Taskname) \#CategoryName(Optional) => Adds given task to todolist"
  puts"2-help => list all the commands you can use"
  puts"3-done (Tasknumber)=> Marks the given task as done\n4-delete (Tasknumber) => Deletes the task from the list permenantly"
  puts"5-list=> Lists all the tasks (done and ongoing)"
  puts"6-up (Tasknumber)=> Increases the priority of a given task number \n(If the higher priority belongs to another task , the tasks will be swapped"
  puts"7-down (Tasknumber)=>Decreases the priority of a given task number \n(If the lower priority belongs to another task , the tasks will be swapped"
  puts"8-list category(CategoryNumber/Name)=>Lists all the tasks in a given category"
elsif(ARGV[0].eql?"list")
  tasks.each do |tsk|
    puts ActiveSupport::JSON.encode(tsk)
  end
elsif(ARGV[0].eql?"delete")
  tasks.each_with_index do |tsk,i|
    if(tsk.priority==ARGV[1]) 
      tasks.delete_at(i)
      flag=1
    end
    #x.delete_at(x.index 2)
end
if(flag!=1)
 puts "This task number is unavaliable" 
 flag=0;
end

end
  #puts ActiveSupport::JSON.encode(tasks[0])
  File.open('demo.json', 'w') { |file| file.truncate(0) }
  File.open('demo.json', 'a') { |file| file.write("[\n") }
  tasks.each_with_index do |tsk, i|
    del = (i == tasks.size-1) ? "\n]" : ",\n"
    File.open('demo.json', 'a') { |file|
      file.write(ActiveSupport::JSON.encode(tsk))
      file.write(del)
    }
  end
