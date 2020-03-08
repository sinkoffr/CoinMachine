class TransactionsController < ApplicationController
  before_action :get_transaction, only: [:show, :update]

  #GET /transactions
  def index
    @transactions = Transaction.all
    json_response(@transactions)
  end

  def show
    json_response(@transaction)
  end

  #GET /transactions/transaction/:api_user
  def get_by_api_user
    @transactions = Transaction.all.find_by(api_user: params[:api_user])
    json_response(@transactions)
  end

  #POST /transactions
  def create
    @coin = Coin.find(params['coin_id'])
    if transaction_params['transaction_type'].downcase == "deposit"
      if @coin.present?
        count = @coin.count + 1
        @coin.update(count: count)
      end
      @transaction = Transaction.create!(transaction_params)
      json_response(@transaction, :created)
    elsif transaction_params['transaction_type'].downcase == "withdrawl"
      if @coin.present?
        count = @coin.count - 1
        if count >= 0
          @coin.update(count: count)
          if count <= 4
            @transaction.send_email(@coin)
          end
        else
          error_response("Sorry, there are not enough coins for this transaction.")
          #TODO gracefully handle error due to not enough coins
        end
      end
      @transaction = Transaction.create!(transaction_params)
      json_response(@transaction, :created)
    else 
      json_response(@transaction)
    end

  end

  #PUT /transactions/:id
  def update
    if transaction_params['transaction_type'].downcase != "deposit" && transaction_params['transaction_type'] != "withdrawl"
      error_response("Incorrect Transaction Type")
    else
      @transaction.update(transaction_params)
      head :no_content
    end
  end



  private

  def transaction_params
    params.permit(:api_user, :coin_id, :transaction_type)
  end

  def get_transaction
    @transaction = Transaction.find(params[:id])
  end
end
