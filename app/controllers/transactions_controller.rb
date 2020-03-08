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
    if transaction_params['transaction_type'].downcase != "deposit" && transaction_params['transaction_type'] != "withdrawl"
      error_response("Incorrect Transaction Type")
    else
      @transaction = Transaction.create!(transaction_params)
      json_response(@transaction, :created)
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
