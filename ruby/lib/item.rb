class Item
  attr_accessor :name, :sell_in, :quality

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def reduce_quality(amount = 1)
    if amount > @quality
      @quality = MIN_QUALITY
    else
      @quality -= amount
    end
  end

  def increase_quality(amount = 1)
    if @quality + amount > MAX_QUALITY
      @quality = MAX_QUALITY
    else
      @quality += amount
    end
  end

end
