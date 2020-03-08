Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :coins
  scope '/coins/all' do
    get '/total'   => 'coins#total'
  end

  resources :transactions
  scope 'transactions/transaction' do
    get '/:api_user'    => 'transactions#get_by_api_user'
  end

  resources :admins
end
