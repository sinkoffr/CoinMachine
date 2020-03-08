class AdminMailer < ApplicationMailer
  default from: "no-reply@coin-machine.com"

  def low_coins(coin)
    @total = Coin.coin_total
    @coin = coin
    @addresses = []
    Admin.all.each do |email|
      @addresses.push(email.email)
    end

    mail(to: @addresses,
         subject: "Low Coin Notification")
  end
end
