class GildedRose

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > MIN_QUALITY
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < MAX_QUALITY
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < MAX_QUALITY
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < MAX_QUALITY
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < MIN_QUALITY
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > MIN_QUALITY
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < MAX_QUALITY
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  # def reduce_quality(amount = 1)
  #   if amount > @quality
  #     @quality = MIN_QUALITY
  #   else
  #     @quality -= amount
  #   end
  # end
  #
  # def increase_quality(amount = 1)
  #   if @quality + amount > MAX_QUALITY
  #     @quality = MAX_QUALITY
  #   else
  #     @quality += amount
  #   end
  # end

end
