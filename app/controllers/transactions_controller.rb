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
    puts @transactions.inspect
    json_response(@transactions)
  end

  #POST /transactions
  def create
    @transaction = Transaction.create!(transaction_params)
    json_response(@transaction, :created)
  end

  #PUT /transactions/:id
  def update
    @transaction.update(transaction_params)
    head :no_content
  end

  private

  def transaction_params
    params.permit(:api_user, :coin_id)
  end

  def get_transaction
    @transaction = Transaction.find(params[:id])
  end
end
