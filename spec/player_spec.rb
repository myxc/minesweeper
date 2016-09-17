require 'player'

describe Player do

	let(:player){Player.new}

	describe '#initialize' do

		it 'should be a player class' do
		  expect(player).to be_a(Player)
		end

		it 'should have a filler string for player name' do
			expect(player.name).to eq("filler")
		end

		it 'should have a filler for game difficulty'	do
			expect(player.difficulty).to eq("filler")
		end
	end

end	
