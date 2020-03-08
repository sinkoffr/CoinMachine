require 'rails_helper'

RSpec.describe 'Coins API', type: :request do
 
  describe 'GET /coins/all/total' do
    context 'when there are no coins present' do
      it 'returns a value of nil' do
        expect(response).to eq(nil)
      end
    end
  end

  
  let!(:coins) { create_list(:coin, 10) }
  let(:coin_id) { coins.first.id }

  describe 'GET /coins/all/total' do
    context 'when coins are present' do
      before { get '/coins/all/total' }
      it 'returns a value' do
        expect(response.body).not_to be_nil 
        expect(json).not_to be_nil 
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end


  describe 'GET/coins' do
    before { get '/coins' }

    it 'returns coins' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET/coins/:id' do
    before { get "/coins/#{coin_id}" }

    context 'when the records exist' do
      it 'returns the coin' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(coin_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:coin_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Coin/)
      end
    end
  end

  describe 'POST/coins' do
    let(:valid_attributes) { { name: 'Quarter', value: '0.25' } }

    context 'when the request is valid' do
      before { post '/coins', params: valid_attributes }

      it 'creates a coin' do
        expect(json['name']).to eq('Quarter')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/coins', params: { name: 'Dime' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Value can't be blank/)
      end
    end
  end

  describe 'PUT /coins/:id' do
    let(:valid_attributes) { { name: 'Penny' } }

    context 'when the record exists' do
      before { put "/coins/#{coin_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty 
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /coins/:id' do
    before { delete "/coins/#{coin_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end