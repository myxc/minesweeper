require 'cell' 

describe Cell do 
	
	let (:cell){Cell.new}

	describe "#initialize" do 

		it "is a Cell" do
			expect(cell).to be_a(Cell)
		end

		it "begins as an empty cell" do
			expect(cell.empty).to be true
		end

	end 
end
