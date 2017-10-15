require 'json'
require 'active_support/json'
require 'byebug'

# puts ARGV.inspect
flag=0
flag2=0
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

f1 = File.read('demo.json')
data = JSON.parse(f1).to_a
tasks = data.map { |tsk| Task.new(tsk['name'], tsk['category'], tsk['priority'])}
$general = (tasks[tasks.size-1].priority.to_i)+1

def sort_tasks(task_array)
  task_array.sort! {|a,b| a.priority <=> b.priority }
  #myarray.sort! { |a, b|  a.attribute <=> b.attribute }
end

sort_tasks(tasks)
if(ARGV[0].eql?"add")
  sort_tasks(tasks)
  ARGV.each_with_index do |arg,i|
    if(i==0 or ARGV[i].include? "@")
      #puts"no"
      if(ARGV[i].include? "@")
        cat=ARGV[i]
        puts ARGV[i]
      end
    else
      temp << ARGV[i].chomp.to_s + " "
    end
  end

  tasks << Task.new(temp)
  puts tasks[$general]
  cat2=cat.sub("@", "")
  if(cat2.eql?"")
    tasks[$general-1].category="general"
  else
    tasks[$general-1].category=cat2
  end
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
  if(ARGV[1].eql?"category")
    #puts"ana hena #{ARGV[1]}"
    s1=ARGV[2]
    tasks.each do |tsk|
      if(tsk.category.eql? s1)
        #puts"ana hena 2"
        puts "Tasks in category #{s1} :"
        puts "#{tsk.priority} - #{tsk.name} //Category: #{tsk.category}"
        #puts ActiveSupport::JSON.encode(tsk)
      end
    end
    # tasks.select { |t| t.category.eql?(s1) }.each { |t| puts "..." }

  else

    sort_tasks(tasks)
    tasks.each do |tsk|
      #puts ActiveSupport::JSON.encode(tsk)
      puts "#{tsk.priority} - #{tsk.name} //Category : #{tsk.category}"
    end
  end
elsif (ARGV[0].eql?"done")
  number=ARGV[1]
  puts "marked (#{number}) as done !"
  tasks.each_with_index do |tsk,i|
    if(tasks[i].priority==number)
      tasks[i].name << "(Done)"
    end
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
elsif (ARGV[0].eql?"up")
  sort_tasks(tasks)
  tasks.each_with_index do |tsk,i|
    if(tsk.priority==ARGV[1])
      tasks[i].priority=(tasks[i].priority.to_i - 1).to_s
      flag2=1;
      if(tasks[i-1].priority==tasks[i].priority)
        tasks[i-1].priority=(tasks[i-1].priority.to_i + 1).to_s
      end
    end
  end
  if(flag2==0)
    puts "Number unavaliable"
  end
elsif (ARGV[0].eql?"down")
  sort_tasks(tasks)

  tasks.each_with_index do |tsk,i|
    if(tsk.priority==ARGV[1])
      tasks[i].priority=(tasks[i].priority.to_i + 1).to_s
      flag2=1;
      # puts"The iteration problem is #{i} and #{tasks[i+1].name}"
      if(tasks[i+1].priority==tasks[i].priority)
        tasks[i+1].priority=(tasks[i+1].priority.to_i - 1).to_s
      end
      break
    end
  end

  if(flag2==0)
    puts "Number unavaliable"
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
