# Comment
puts "Hello World !"
print "Enter a value :"
num1= gets.to_i
print "Enter Second Value :"
num2=gets.to_i
puts num1.to_s + "+" + num2.to_s + "=" + (num1.to_i+num2.to_i).to_s
=begin
	Comment
	using
	multiple lines
=end
puts "t&&f="+ (true and false).to_s
############################################
def get_lang
	puts "Please enter language"
	lang = gets.chomp
	puts lang
	case lang
	when "french"
		puts "Bonj"
		exit
	else
		puts "Eshta"
	end
end
get_lang()
############################################
numbers=[1,2,3,4,"mido",6]
numbers.each do |nu|
	puts "Numbers #{nu}"
end
############################################
for nu in numbers
	puts "Numbers #{nu}"
end
############################################
long_string=<<EOM
Hello   1   1   1
World
!
EOM
puts long_string
############################################
array1=Array.new
array2=Array.new(5)
array3=Array.new(5,"empty")
array4=[1,2,3,4]
puts array1
puts array4
array4[2,2] ## bageeb men awel position 2 w kman 2 b3daha
puts array4.values_at(0,1,3).join(", ")
array4.unshift(4)
puts array4
array4.shift()
puts array4
array4.push(100,1001,10001)
puts array4
array4.pop
puts array4
array4.size()
array4.include?(100)
array4.count(100)
array4.empty?
p array4   ###prints array
array4.shift(2)
puts array4
class Animal
	def initialize 
		puts "Animal created"
	end
	def set_name(name)
		@name=name
	end
	def get_name
		@name
	end
end
cat = Animal.new
class Dog
	attr_accessor :name, :height , :weight ## aw attr_reader we attr_writer
	def bark
		return "Normal Bark"
	end
end
boxer=Dog.new
## puts boxer.get_name
class German < Dog
end
roy=German.new
puts roy.bark
############################################
module Human
	attr_accessor :name

	def run
		puts @name + " runs"
	    puts self.name + " runs"
	    height = "asd"
	end

	private
		attr_accessor :height
end
module Knowledge
	def smart
		puts "Good"
	end
end
class Teacher 
	include Human   
	prepend  Knowledge    ## el far2 mabenhom en prepend dyman haykoon leeh awlaweya we hata5od el function bt3tha msh over-rideen
end
Mohamed=Teacher.new
Mohamed.name="Mo"
Mohamed.run
############################################
# Ay variable . object_id bytl3 makano fel memory
# ay 7aga . methods bydeek kol el methods el gowa el class da 
############################################
number_hash={"pi"=>3.14,
			 "e"=>2.718}

h2={"pi"=>3.142,"e"=>2.718}
puts number_hash.merge(h2) { |k,o,n| o < n ? n:o}   ## law merge! byghayar el number_hash permenantly
puts number_hash["pi"]
boolean=Hash["true",1,"false",0]
puts boolean["true"]
boolean.update(number_hash) ##aw merge bs update btsheel el duplicates
puts boolean["pi"]
puts boolean
puts boolean.has_key?("true")
puts boolean.has_value?("1")
puts boolean.empty?.to_s
puts boolean.size.to_s
############################################
# Code Blocks
array=[1,2,3,4,5]
array.each{|num| puts num*20} #num here is a block variable and is not seen everywhere (scope)
#Using find Blocks
puts (1..10).find{|i| i==5}
puts (1..10).find_all{|i| i%3==0}
puts (1..10).select{|i| (1..10).include?(i*3)}
puts (1..10).any?{|i| i%3==0}
puts (1..10).all?{|i| i%3==0}
puts [*1..10].delete_if{|i| i%3==0} ##### Change it to array so we can delete from
#using collect Blocks # Always returns an array and return nill if the the input is not specified
array=[1,2,3,4,5].collect!{|i| i+1}  ## the ! changes the array per
puts array
fruits_array=["apple","peach","orange"].map!{ |fruit| fruit=="peach"? fruit.capitalize : fruit }
puts fruits_array 
#### here are 2 ways of using the blocks 
fruits_array.map do |fruit| 
	if fruit=="orange" 
		fruit.capitalize! 
	else 
		fruit
	end
end
puts fruits_array
#using inject blocks 


