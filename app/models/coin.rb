class Coin < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :value

  def self.coin_total
    @total = 0
    Coin.all.each do |coin|
      @value = ((coin.value).to_f * coin.count)
      @total += @value
    end
    @total
  end

end
