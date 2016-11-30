require_relative '../lib/gilded_rose'
require_relative '../lib/item'
require_relative 'spec_helper'

describe GildedRose do

  describe "#update_quality" do

    let(:item0) { Item.new("MyItem", 10, 40) }
    let(:item1) { Item.new("MyItem", 0, 40) }
    let(:gilded_rose) { GildedRose.new([item0, item1]) }

    before(:each) do
      gilded_rose.update_quality
    end

    it 'reduces the quality by 1 each time' do
      expect(gilded_rose.items[0].quality).to eq 39
    end

    it 'reduces the quality by 2 after the sell by date has passed' do
      expect(gilded_rose.items[1].quality).to eq 38
    end

    it "will not reduce the quality beyond the minimum" do
      50.times do
        gilded_rose.update_quality
      end
      expect(gilded_rose.items[0].quality).to eq GildedRose::MIN_QUALITY
    end

    it 'reduces the sell_in by 1 each time' do
      expect(gilded_rose.items[0].sell_in).to eq 9
    end

    it 'ensures that quality is never higher than 50' do
      expect(gilded_rose.items[0].quality).to be <= GildedRose::MAX_QUALITY
    end

  end

  describe "#update_quality for Aged Brie" do

    let(:item0) { Item.new("Aged Brie", 10, 40) }
    let(:gilded_rose) { GildedRose.new([item0]) }

    it "increases in quality the older it gets" do
      gilded_rose.update_quality
      expect(gilded_rose.items[0].quality).to eq 41
    end

    it "will not increase the quality beyond the maximum" do
      GildedRose::MAX_QUALITY.times do
        gilded_rose.update_quality
      end
      expect(gilded_rose.items[0].quality).to eq GildedRose::MAX_QUALITY
    end
  end

  describe "#update_quality for Sulfuras" do

    let(:item0) { Item.new("Sulfuras, Hand of Ragnaros", 10, 40) }
    let(:item1) { Item.new("Sulfuras, Hand of Ragnaros", 10, 80) }
    let(:gilded_rose) { GildedRose.new([item0, item1]) }

    before(:each) do
      gilded_rose.update_quality
    end

    it "does not change in quality" do
      expect(gilded_rose.items[0].quality).to eq 40
    end

    it "does not change its sell_in date" do
      expect(gilded_rose.items[0].sell_in).to eq 10
    end

    it 'ensures that quality is never higher than 50' do
      expect(gilded_rose.items[1].quality).to be <= GildedRose::MAX_QUALITY
    end
  end

  describe "#update_quality for Backstage passes" do

    let(:concert0) { Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20) }
    let(:concert1) { Item.new("Backstage passes to a Tina Turner concert", 10, 20) }
    let(:concert2) { Item.new("Backstage passes to a Rolling Stones concert", 5, 20) }
    let(:concert3) { Item.new("Backstage passes to a Hot Chip concert", 5, 48) }
    let(:concert4) { Item.new("Backstage passes to an Expired", 0, 20) }
    let(:gilded_rose) { GildedRose.new([concert0, concert1, concert2, concert3, concert4]) }

    before(:each) do
      gilded_rose.update_quality
    end

    it "increases in quality the older it gets" do
      expect(gilded_rose.items[0].quality).to eq 21
    end

    it "increases in quality by 2 once the selling days gets to 10 or fewer" do
      expect(gilded_rose.items[1].quality).to eq 22
    end

    it "increases in quality by 3 once the selling days gets to 5 or fewer" do
      expect(gilded_rose.items[2].quality).to eq 23
    end

    it 'ensures that quality is never higher than 50' do
      expect(gilded_rose.items[3].quality).to be <= GildedRose::MAX_QUALITY
    end

    it "drops the quality to 0 after the concert" do
      expect(gilded_rose.items[4].quality).to eq 0
    end
  end

  describe "#update_quality for Conjured items" do

    let(:item0) { Item.new("Conjured Mana Cake", 10, 40) }
    let(:item1) { Item.new("Conjured Mana Cake", 0, 40) }
    let(:gilded_rose) { GildedRose.new([item0, item1]) }

    before(:each) do
      gilded_rose.update_quality
    end

    it 'reduces the quality by 2 each time (twice the usual rate)' do
      expect(gilded_rose.items[0].quality).to eq 38
    end

    it 'reduces the quality by 4 after the sell by date has passed (twice the usual rate)' do
      expect(gilded_rose.items[1].quality).to eq 36
    end
  end
end
