Rails.application.routes.draw do
  scope '/api' do
    resources :users, param: :_username
    get '/user/me', to: 'users#me'
    post '/auth/login', to: 'authentication#login'

    resources :categories, param: :_title
  end
end
