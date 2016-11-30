require_relative '../lib/gilded_rose'
require_relative '../lib/item'
require_relative 'spec_helper'

describe GildedRose do

  describe "#update_quality" do

    before(:each) do
      items = [Item.new("MyItem", 10, 40)]
      @gilded_rose = GildedRose.new(items)
    end

    it 'reduces the quality by 1 each time' do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].quality).to eq 39
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

  describe '#reduce_quality' do

    before(:each) do
      items = [Item.new("MyItem", 10, 40)]
      @gilded_rose = GildedRose.new(items)
    end

    it "reduces the quality by a default of 1" do
      @gilded_rose.reduce_quality(@gilded_rose.items[0])
      expect(@gilded_rose.items[0].quality).to eq 39
    end

    it "reduces the quality by the amount passed" do
      @gilded_rose.reduce_quality(@gilded_rose.items[0], 5)
      expect(@gilded_rose.items[0].quality).to eq 35
    end

    it "will not reduce the quality to below the minimum quality" do
      @gilded_rose.reduce_quality(@gilded_rose.items[0], 41)
      expect(@gilded_rose.items[0].quality).to eq GildedRose::MIN_QUALITY
    end
  end

  describe '#increase_quality' do

    before(:each) do
      items = [Item.new("MyItem", 10, 40)]
      @gilded_rose = GildedRose.new(items)
    end

    it "increases the quality by a default of 1" do
      @gilded_rose.increase_quality(@gilded_rose.items[0])
      expect(@gilded_rose.items[0].quality).to eq 41
    end

    it "increases the quality by the amount passed" do
      @gilded_rose.increase_quality(@gilded_rose.items[0], 5)
      expect(@gilded_rose.items[0].quality).to eq 45
    end

    it "will not increase the quality beyond 50" do
      @gilded_rose.increase_quality(@gilded_rose.items[0], 11)
      expect(@gilded_rose.items[0].quality).to eq GildedRose::MAX_QUALITY
    end
  end

end
