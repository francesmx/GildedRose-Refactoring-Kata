class GildedRose

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def items
    @items.dup
  end

  def update_quality()
    @items.each do |item|
      case
        when item.name == "Aged Brie"
          update_quality_for_brie(item)
        when item.name.include?("Backstage passes")
          update_quality_for_backstage(item)
        when item.name.include?("Sulfuras")
          increase_quality(item, 0)
        when item.name.include?("Conjured")
          update_quality_for_conjured(item)
        else
          update_quality_standard(item)
      end
    end
  end

  private

  def update_quality_for_brie(item)
    increase_quality(item)
    reduce_sell_in(item)
  end

  def update_quality_for_backstage(item)
    case
      when item.sell_in > 5 && item.sell_in < 11
        increase_quality(item, 2)
      when item.sell_in > 0 && item.sell_in < 6
        increase_quality(item, 3)
      when item.sell_in <= 0
        item.quality = 0
      else
        increase_quality(item)
    end
    reduce_sell_in(item)
  end

  def update_quality_for_conjured(item)
    if item.sell_in <= 0
      reduce_quality(item, 4)
    else
      reduce_quality(item, 2)
    end
    reduce_sell_in(item)
  end

  def update_quality_standard(item)
    if item.sell_in <= 0
      reduce_quality(item, 2)
    else
      reduce_quality(item, 1)
    end
    reduce_sell_in(item)
  end

  def reduce_quality(item, amount = 1)
    if amount > item.quality
      item.quality = MIN_QUALITY
    else
      item.quality -= amount
    end
  end

  def increase_quality(item, amount = 1)
    if item.quality + amount > MAX_QUALITY
      item.quality = MAX_QUALITY
    else
      item.quality += amount
    end
  end

  def reduce_sell_in(item, amount = 1)
    item.sell_in -= amount
  end

end
