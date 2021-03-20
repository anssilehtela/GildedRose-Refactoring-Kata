class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      quality_change = 0
      case item.name
      when "Sulfuras, Hand of Ragnaros"
        next
      when /Aged Brie/
        quality_change = 1
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in < 1
          item.quality = 0
          item.sell_in = item.sell_in - 1
          next
        end
        quality_change = if item.sell_in < 6
          3
        elsif item.sell_in < 11
          2
        else
          1
        end
      else
        quality_change = -1
      end
      quality_change = quality_change * 2 if item.sell_in < 1
      item.quality = item.quality + quality_change
      item.quality = 50 if item.quality > 50
      item.quality = 0 if item.quality < 0
      item.sell_in = item.sell_in - 1
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
