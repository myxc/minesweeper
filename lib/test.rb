test = Array.new(10) {Array.new(10) {1..10}}
@flags = []
@j = 23
@n = 34
test.each_with_index do |row,index|
	row.each do |col|
		puts "we're on row #{index} column #{col}!"
	end
end
@flags << "#{@j}#{@n}"
puts Integer(@flags[0]) + 1