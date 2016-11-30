require_relative '../lib/item'

describe Item do

  describe "#initialize" do
    it "initializes an item" do
      item = Item.new("MyItem", 20, 50)
      expect(item.name).to eq "MyItem"
      expect(item.sell_in).to eq 20
      expect(item.quality).to eq 50
    end
  end

end
