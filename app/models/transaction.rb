class Transaction < ApplicationRecord
  belongs_to :coin
  validates_presence_of :api_user

  def send_email
    AdminMailer.low_coins.deliver_now
  end
end
