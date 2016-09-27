require_relative 'board'
require_relative 'player'

class Minesweeper_game

	def initialize 
		@row = 10
		@col = 10
	end

	def new_game

		player = Player.new
		board = Board.new

		board.gen_bombs

		board.fill_tile #fills board.grid with empty, bomb, and numbered cells

		board.refresh

		while true
			board.render #renders board.

			if board.user_prompt == false
				break
			end
		end
	end
end

game = Minesweeper_game.new 
game.new_game
