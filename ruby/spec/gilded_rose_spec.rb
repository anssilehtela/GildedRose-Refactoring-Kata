#require File.join(File.dirname(__FILE__), 'gilded_rose')
require_relative '../gilded_rose'
require 'approvals/rspec'

Approvals.configure do |config|
  config.approvals_path = 'output/goes/here/'
end

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "When item is Aged Brie" do
      let(:item){ Item.new("Aged Brie", 0, 0) }
    end
  end

  context 'approvals' do
    before do 
      items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20),
               Item.new(name="Aged Brie", sell_in=2, quality=0),
               Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7),
               Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
               Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
               Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
               Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
               Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
               # This Conjured item does not work properly yet
               Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
              ]
      @item_array = []
      gilded_rose = GildedRose.new(items)
      25.times do
        gilded_rose.update_quality
        @item_array << items.map { |i| i.to_s }
      end
    end
    it 'works' do
      verify do
        @item_array
      end
    end
  end

end
