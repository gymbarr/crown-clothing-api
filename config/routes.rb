Rails.application.routes.draw do
  resources :users, param: :username
  post '/auth/login', to: 'authentication#login'
end
