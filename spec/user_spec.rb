require './lib/user'

describe User do

  describe ".is_username_empty?" do
    context "check string" do
      it "returns true" do
        expect(User.is_username_empty?("")).to eq(true)
      end
    end
  end
end