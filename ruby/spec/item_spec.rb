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

  describe '#reduce_quality' do
    it "reduces the quality by the amount passed" do
      item = Item.new("MyItem", 20, 50)
      item.reduce_quality(1)
      expect(item.quality).to eq 49
    end
  end
end
