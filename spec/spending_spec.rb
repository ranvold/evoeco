require './lib/spending'

describe Spending do

  describe ".is_price_correct?" do
    context "check a price" do
      it "returns true" do
        expect(Spending.is_price_correct?("250")).to eq(true)
      end
    end
  end
  describe ".is_date_correct?" do
    context "check a leap year" do
      it "returns false" do
        expect(Spending.is_date_correct?("2022.02.29", 'day')).to eq(false)
      end
    end
  end
end