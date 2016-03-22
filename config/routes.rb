Rails.application.routes.draw do

  root 'pages#home'

  resources :pictures, except: [:show, :destroy]
  resources :subcategories, only: [:show]
  resources :categories, only: [:show]
  resources :posts
  resources :approved_buy_cats, except: [:destroy]
  resources :approved_sell_cats, except: [:destroy]
  resources :trades, only: [:show]
  resources :bids, only: [:create, :destroy]

  devise_for :traders

  get '/home', to: 'pages#home'
  get '/profile/:id', to: 'pages#profile', :as => 'profiles'
  get '/about_us', to: 'pages#about_us'
  get '/approved', to: 'pages#approved'
  post '/feedback', to: 'pages#feedback'
  get '/statistics', to: 'pages#statistics'

  get '/approval', to: 'administration#approval'
  post '/approve/buy', to: 'administration#approveBuy'
  post '/decline/buy', to: 'administration#declineBuy'
  post '/approve/sell', to: 'administration#approveSell'
  post '/decline/sell', to: 'administration#declineSell'

  post '/report', to: 'posts#report'
  get '/reported', to: 'administration#reported'
  post '/reported/dismiss', to: 'administration#dismiss'
  post '/reported/delete', to: 'administration#delete'

  post '/request_sample', to: 'posts#request_sample'
  post '/sample_delivered', to: 'posts#request_delivered'

  get '/delivery', to: 'administration#delivery'
  post '/delivery/dismiss', to: 'administration#deliveryDismiss'

  get '/completed', to: 'administration#completed'
  post '/completed/seller', to: 'administration#seller'
  post '/completed/buyer', to: 'administration#buyer'
  post '/completed/export', to: 'administration#export'

  get '/paypal', to: 'trades#paypal'
  get "/paypal/execute", to: 'trades#execute'
end
