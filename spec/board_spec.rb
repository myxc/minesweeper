require 'board'
require './lib/cell'

describe Board do

	let (:board){Board.new}

	describe "#initialize" do 

		it "is board class" do
			expect(board).to be_a(Board)
		end

		it "is empty" do
			expect(board.board).to eq([])
		end

		it "attr_reader works properly" do 
			expect(board.test).to eq("test")
		end

		it "creates grid per size spec of player" do
			expect(board.grid).to eq(Array.new(10) {Array.new(10) {Cell.new}})
		end

		it "creates array to hold bomb coords" do
			expect(board.bombs).to eq([])
		end
	end
end	