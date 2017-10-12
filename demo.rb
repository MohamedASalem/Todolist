require 'json'

tasks=Array.new

class Task
  attr_accessor :name , :category, :priority

  def initialize(name)
    self.name=name
    self.category="general"
    self.priority=$general
  end

  def initialize(name,category,priority)
    self.name=name
    self.category=category
    self.priority=priority
  end

end
f1=File.read('demo.json')
data=JSON.parse(f1)
tasks = data['Tasks'].map { |tsk| Task.new(tsk['name'], tsk['category'],tsk['priority'])}
puts tasks
 # new_task = Task.new(json_object["Task"])
# json_object.each_with_index do |index|
#	new_task = Task.new(json_object["#{index}"])
#	tasks << new_task