require 'rails_helper'

RSpec.describe 'Transactions API', type: :request do
  let!(:coin) { create(:coin) }
  let(:transaction_type) { "DEPOSIT" }
  let!(:transactions) { create_list(:transaction, 20, coin_id: coin.id, transaction_type: transaction_type) }
  let(:coin_id) { coin.id }
  let(:api_id) { transactions.first.api_user }
  let(:id) { transactions.first.id }
  let(:authorization) { "api-key-1"}

  describe "with valid token", validToken: true do
    before(:each) { authorization }

    describe 'GET /transactions' do
      before { get "/transactions" }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all transactions' do
        expect(json.size).to eq(20)
      end
    end
      
    describe 'GET /transactions/transaction/:api_id' do
      before { get "/transactions/transaction/#{api_id}" }

      context 'when transactions exist for the api_user' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns all transactions for the api_user' do
          expect(json.size).to be > 1
        end
      end

      context 'when transactions do not exist for api_user' do
        let(:api_id) { nil }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Transaction with 'id'=transaction/)
        end
      end
    end

    describe 'POST /transactions' do
      let(:valid_attributes) { { coin_id: coin_id, api_user: api_id, transaction_type: transaction_type } }

      context 'when request attributes are valid' do
        before { post "/transactions", params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when invalid request' do
        before { post "/transactions", params: {} }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Couldn't find Coin without an ID/)
        end
      end
    end

    describe 'GET /transactions/:id' do
      before { get "/transactions/#{id}" }

      context 'when transaction exists' do
        it 'returns with status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns the transaction' do
          expect(json['id']).to eq(id)
        end
      end

      context 'when the transaction does not exist' do
        let(:id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Transaction/)
        end
      end
    end

    describe 'PUT /transactions/:id' do
      let(:valid_attributes) { { coin_id: coin.id, transaction_type: transaction_type } }

      before { put "/transactions/#{id}", params: valid_attributes }

      context 'when transaction exists' do
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        it 'updates the transaction' do
          updated_transaction = Transaction.find(id)
          expect(updated_transaction.coin_id).to match(coin.id)
        end
      end

      context 'when the transaction does not exist' do
        let(:id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Transaction/)
        end
      end
    end
  end
end