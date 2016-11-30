require_relative '../lib/gilded_rose'
require_relative '../lib/item'
require_relative 'spec_helper'

describe GildedRose do

  describe "#update_quality" do

    before(:each) do
      item0 = Item.new("MyItem", 10, 40)
      item1 = Item.new("MyItem", 0, 40)
      items = [item0, item1]
      @gilded_rose = GildedRose.new(items)
    end

    it 'reduces the quality by 1 each time' do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 39
    end

    it 'reduces the quality by 2 after the sell by date has passed' do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[1].quality).to eq 38
    end

    it "will not reduce the quality beyond the minimum" do
      41.times do
        @gilded_rose.update_quality
      end
      expect(@gilded_rose.items[0].quality).to eq GildedRose::MIN_QUALITY
    end

    it 'reduces the sell_in by 1 each time' do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].sell_in).to eq 9
    end

    it 'ensures that quality is never higher than 50' do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to be <= GildedRose::MAX_QUALITY
    end

  end

  describe "#update_quality for Aged Brie" do

    before(:each) do
      items = [Item.new("Aged Brie", 10, 40)]
      @gilded_rose = GildedRose.new(items)
    end

    it "increases in quality the older it gets" do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 41
    end

    it "will not increase the quality beyond the maximum" do
      GildedRose::MAX_QUALITY.times do
        @gilded_rose.update_quality
      end
      expect(@gilded_rose.items[0].quality).to eq GildedRose::MAX_QUALITY
    end
  end

  describe "#update_quality for Sulfuras" do

    it "does not change in quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 40)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 40
    end

    it "does not change its sell_in date" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 40)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].sell_in).to eq 10
    end

    it 'ensures that quality is never higher than 50' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to be <= GildedRose::MAX_QUALITY
    end
  end

  describe "#update_quality for Backstage passes" do

    it "increases in quality the older it gets" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 21
    end

    it "increases in quality by 2 once the selling days gets to 10 or fewer" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 22
    end

    it "increases in quality by 3 once the selling days gets to 5 or fewer" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 23
    end

    it 'ensures that quality is never higher than 50' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 48)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to be <= GildedRose::MAX_QUALITY
    end

    it "drops the quality to 0 after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 0
    end
  end

  describe "#update_quality for Conjured items" do

    before(:each) do
      item0 = Item.new("Conjured Mana Cake", 10, 40)
      item1 = Item.new("Conjured Mana Cake", 0, 40)
      items = [item0, item1]
      @gilded_rose = GildedRose.new(items)
    end

    it 'reduces the quality by 2 each time (twice the usual rate)' do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 38
    end

    it 'reduces the quality by 4 after the sell by date has passed (twice the usual rate)' do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[1].quality).to eq 36
    end
  end
end
