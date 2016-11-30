require_relative '../lib/item'

describe Item do

  describe "#initialize" do
    it "initializes an item" do
      item = Item.new("MyItem", 20, 40)
      expect(item.name).to eq "MyItem"
      expect(item.sell_in).to eq 20
      expect(item.quality).to eq 40
    end
  end

  describe '#reduce_quality' do

    it "reduces the quality by the amount passed" do
      item = Item.new("MyItem", 20, 40)
      item.reduce_quality(1)
      expect(item.quality).to eq 39
    end

    it "will not reduce the quality to below the minimum quality" do
      item = Item.new("MyItem", 20, 40)
      item.reduce_quality(41)
      expect(item.quality).to eq Item::MIN_QUALITY
    end
  end

  describe '#increase_quality' do

    it "increases the quality by the amount passed" do
      item = Item.new("MyItem", 20, 40)
      item.increase_quality(1)
      expect(item.quality).to eq 41
    end

    it "will not increase the quality beyond 50" do
      item = Item.new("MyItem", 20, 30)
      item.increase_quality(21)
      expect(item.quality).to eq Item::MAX_QUALITY
    end
  end
end
