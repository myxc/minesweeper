require_relative 'player'
require_relative 'cell'

class Board
	attr_reader :board, :grid, :test, :bombs

	def initialize
		@board = []
		@grid = Array.new(10) {Array.new(10) {Cell.new}}
		@test = "test" #just part of an RSpec test to make sure code was working
		@bombs = [] #empty array to store random bomb #'s 
		@i = 10 #these are used for bomb related methods
		@j = 10 #^
		@row = 10#used for user entries
		@col = 10#^
	end

	def gen_bombs #generates number of bombs per specifications
		puts "called gen_bombs"
		until @bombs.size == 9 #9 can/will be replaced by variable that user can specify FOR CUSTOM
			random_num = rand(1..99) #this rand range will also be changed to variables that user can spec FOR CUSTOM
			unless @bombs.include? random_num
				@bombs << random_num
			end
		end
		@bombs.sort #unnecessary
	end

	def get_coords(num)
		@i = num/10
		@j = num%10
	end

	def fill_tile
		#update cells that hold bombs
		puts "called fill tile"
		@bombs.each do |bomb|
			get_coords(bomb)
			@grid[@i][@j].set_bomb
		end

		#check every cell to see if the cells around it contain bombs
		@grid.each_with_index do |row,r_index|
			row.each_with_index do |col, c_index|
				counter = 0
				#check cells surrounding it.
				if (c_index - 1) >= 0 #for column to left of current cell
					if (r_index - 1) >= 0 #for row above current cell
						if @grid[r_index - 1][c_index - 1].has_bomb
							counter += 1
						end
					end
					if @grid[r_index][c_index - 1].has_bomb #for row of current cell
						counter += 1
					end
					if (r_index + 1) <= 9 #for row below current cell
						if @grid[r_index + 1][c_index - 1].has_bomb
							counter += 1
						end
					end
				end

				if (r_index - 1) >= 0 #for row above current cell
					if @grid[r_index - 1][c_index].has_bomb
						counter += 1
					end
				end
				if (r_index + 1) <= 9 #for row below current cell
					if @grid[r_index + 1][c_index].has_bomb
						counter += 1
					end
				end

				if (c_index + 1) <=9 #for column to right of current cell
					if (r_index - 1) >= 0 #for row above current cell
						if @grid[r_index - 1][c_index + 1].has_bomb
							counter += 1
						end
					end
					if @grid[r_index][c_index + 1].has_bomb #for row of current cell
						counter += 1
					end
					if (r_index + 1) <= 9 #for row below current cell
						if @grid[r_index + 1][c_index + 1].has_bomb
							counter += 1
						end
					end
				end

				if counter > 0
					@grid[r_index][c_index].surrounding_bombs_setter(counter)
				end
			end
		end
	end #fill tile works properly

	def render
		print "rw1 rw2 rw3 rw4 rw5 rw6 rw7 rw8 rw9 r10\n"
		(0..9).each do |row|
			(0..9).each do |col|
				if @grid[row][col].is_flagged
					print "FLG"
				elsif @grid[row][col].is_hidden
					print "   "
				elsif @grid[row][col].surrounding_bombs > 0
					print " #{@grid[row][col].surrounding_bombs} "
				elsif @grid[row][col].has_bomb
					print "POW"					
				else print "xxx"
				end
				print "|" unless col == 9
				print "col#{row + 1}\n" if col == 9
			end
		end
	end #render works properly

	def unhide_bombs #for when the user clicks a tile that contains a bomb and loses. unhides all bombs and renders with loss msg.
		@bombs.each do |bomb|
			get_coords(bomb)
			@grid[@i][@j].unhide
		end
	end

	def unhide_tiles(row_num, col_num) #for when the user clicks an empty tile, it will reveal all empty tiles enclosed by numbered tiles.
		if @grid[row_num][col_num].is_empty #no number no bomb and hidden
			@grid[row_num][col_num].unhide #unhides it and checks around it
			reveal_cell(row_num - 1, col_num - 1)
            reveal_cell(row_num - 1, col_num)
            reveal_cell(row_num - 1, col_num + 1)
            reveal_cell(row_num + 1, col_num)

            reveal_cell(row_num, col_num - 1)
            reveal_cell(row_num, col_num + 1)
            reveal_cell(row_num + 1, col_num - 1)
            reveal_cell(row_num + 1, col_num + 1)
        else
        	@grid[row_num][col_num].unhide #if this first tile is a number it just gets unhidden.
        end
    end#needs a bit of work it doesn't reveal numbers

	def reveal_cell(row_num, col_num) #planning to be used recursively, used after ensuring the user did not click on a bomb.
		if (row_num <= 9 && row_num >=0) and (col_num <= 9 && col_num >=0)
			if @grid[row_num][col_num].is_hidden #if this tile is empty it'll unhide and then propagate
				#@grid[row_num][col_num].unhide
				unhide_tiles(row_num, col_num)
			else
				@grid[row_num][col_num].unhide #if this tile is a number it'll just unhide and won't propagate off it.
			end
		end
	end #needs bit of work it doesn't reveal edge nubers

	def cell_flagger(row_num, col_num)
		@grid[row_num][col_num].flagger
	end

	def check_win #if all tiles that don't have bombs are no longer hidden then player wins
		@win_counter = 0
		@grid.each_with_index do |row, r_index|
			row.each_with_index do |col, c_index|
				@win_counter += 1 unless @grid[r_index][c_index].is_hidden
			end
		end
		if @win_counter == (100 - 9)
			puts "You won the game!"
			return true
		else
			return false
		end
	end

	def check_bomb(row_num, col_num) #returns true if there's a bomb here, whi reveals all bombs and loss msg.
		if @grid[row_num][col_num].has_bomb
			puts "You have lost the game!!!"
			unhide_bombs
			render
			return true
		else
			return false
		end
	end

	def user_prompt
		while true
			puts "Please enter row (row 1 is top row, row 10 is bottom row)"
			string_row = gets.strip
			@row = Integer(string_row) - 1
			if @row <= 9 and @row >= 0
				break
			end
		end
		while true
			puts "please enter col (col 1 is first row from the left, col 10 is last row)"
			string_col = gets.strip
			@col = Integer(string_col) - 1
			if @col <= 9 and @col >= 0
				break
			end
		end
		puts "enter (2/flag/f) to flag it, anything else will count as clicking it"
		if ["2", "flag", "f"].include?(gets.to_s.downcase.strip) #if input is 2 or flag or f indicating user wants to flag shit
			cell_flagger(@row, @col)
		elsif check_bomb(@row, @col) == true #input isn't flag, check coords and return false indicating game is over
			return false
		else
			unhide_tiles(@row, @col)#if the coords are not a bomb, then reveal the tile/tiles
		end
		if check_win == true
			return false #if they won then return false indicating game ended
		end				
	end

end