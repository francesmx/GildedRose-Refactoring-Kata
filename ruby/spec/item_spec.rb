require_relative '../lib/item'

describe Item do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      expect(items[0].name).to eq "foo"
    end
  end

end
