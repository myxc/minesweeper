require 'player'

describe Player do

	let(:player){Player.new}

	describe "#initialize" do

		it "is player class" do
		  expect(player).to be_a(Player)
		end

		it "filler string for player name" do
			expect(player.name).to eq("filler")
		end

		it "default string for game difficulty"	do
			expect(player.difficulty).to eq("default")
		end

		it "default integer for player width" do 
			expect(player.player_width).to eq(10)
		end

		it "default integer for player height" do 
			expect(player.player_height).to eq(10)
		end

		it "default integer for number of bombs" do
			expect(player.player_bombs).to eq(9)
		end
	end

	describe "#get_name" do


	end

end	
