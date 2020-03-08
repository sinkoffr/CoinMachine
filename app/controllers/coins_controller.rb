class CoinsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :set_coin, only: [:show, :update, :destroy]
  # before_action :restrict_access

  #GET /coins
  def index
    @coins = Coin.all
    json_response(@coins)
  end

  #POST /coins
  def create
    @coin = Coin.create!(coin_params)
    json_response(@coin, :created)
  end

  #Get /coins/:id
  def show
    json_response(@coin)
  end

  #PUT /coins/:id
  def update
    @coin.update(coin_params)
    head :no_content
  end

  #DELETE /coins/:id
  def destroy
    @coin.destroy
    head :no_content
  end

  #GET /coins/total
  def total
    @coins = Coin.all
    @total = 0
    @coins.each do |coin|
      @value = ((coin.value).to_f * coin.count)
      @total += @value
    end
    
    json_response(@total, :ok)

  end

  private

  def coin_params
    params.permit(:name, :value, :count)
  end

  def set_coin
    @coin = Coin.find(params[:id])
  end

  def restrict_access
    authenticate_or_request_with_http_token do | token, options |
      ApiKey.exists?(access_token: token)
    end
  end
end
