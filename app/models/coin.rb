class Coin < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :value


end
