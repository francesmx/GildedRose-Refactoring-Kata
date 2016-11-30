class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def reduce_quality(amount)
    if amount > @quality
      @quality = 0
    else
      @quality -= amount
    end
  end

  def increase_quality(amount)
    @quality += amount
  end

end
