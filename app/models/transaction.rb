class Transaction < ApplicationRecord
  belongs_to :coin
  validates_presence_of :api_user
end
