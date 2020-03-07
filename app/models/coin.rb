class Coin < ApplicationRecord
  validates_presence_of :name, :value

end
