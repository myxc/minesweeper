class Player 
	attr_reader :name, :difficulty, :player_width, :player_height, :player_bombs
	attr_accessor :gamefile
	
	def initialize
		@name = "filler"
		@difficulty = "default"
		@player_width = 10
		@player_height = 10
		@player_bombs = 9
		gamefile = Hash.new #this can be written into to save the game for a certain player.
	end

	def get_player
		puts "Please enter your name"
		@name = gets.chomp
		puts "Default difficulty is 10x10 board \n Would you like to specify board dimensions? (Y/N)"
		input = gets.strip
		if input == "Y"
			@difficulty = "custom"
			puts "enter desired number of rows"
			@player_height = gets.chomp
			puts "enter desired number of columns"
			@player_width = gets.chomp
			puts "enter desired number of bombs"
			@player_bombs = gets.chomp
			puts "Thanks"
		else
			puts "Thanks"
		end
	end
end
