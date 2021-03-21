require_relative 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if legendary?(item)
      quality_change = case item.name
      when "Aged Brie"
        1
      when "Backstage passes to a TAFKAL80ETC concert"
        concert_quality(item)
      else
        #Assuming the conjuration applies only to "normal" items
        conjured?(item) ? -2 : -1
      end
      quality_change *= 2 if item.sell_in < 1
      item.quality += quality_change
      item.quality = 50 if item.quality > 50
      item.quality = 0 if item.quality < 0
      item.sell_in -= 1
    end
  end

  def concert_quality(item)
    if item.sell_in < 1
      item.quality = 0
      0
    elsif item.sell_in < 6
      3
    elsif item.sell_in < 11
      2
    else
      1
    end
  end

  def legendary?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  #Assuming this is the identification method, as the Item class cannot be touched
  def conjured?(item)
    item.name.start_with? "Conjured"
  end
end
