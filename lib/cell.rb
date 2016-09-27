class Cell
	attr_accessor :flagged, :bomb_present, :surrounding_bombs

	def initialize 
		@flagged = false
		@bomb_present = false
		@surrounding_bombs = 0
		@hidden = true #if not hidden, then it will no longer be selectable
	end

	def set_bomb
		@bomb_present = true
	end

	def has_bomb
		if @bomb_present == true
			return true
		end
	end

	def surrounding_bombs_setter(num)
		@surrounding_bombs = num
	end

	def is_hidden
		if @hidden == true
			return true
		else 
			return false
		end
	end

	def is_empty
		if @surrounding_bombs == 0 and @bomb_present == false
			return true
		else
			return false
		end
	end

	def unhide
		@hidden = false
	end

	def flagger
		if @flagged == false
			@flagged = true
		else
			@flagged = false
		end
	end
end