Rails.application.routes.draw do
  scope '/api' do
    resources :users, param: :_username
    post '/auth/login', to: 'authentication#login'

    resources :categories, param: :_title
  end
end
