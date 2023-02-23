# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/api' do
    resources :users, param: :_username
    get '/user/me', to: 'users#me'
    post '/auth/login', to: 'authentication#login'

    resources :categories, param: :category_title do
      member do
        resources :products do
          member do
            get '/show_variants', to: 'products#show_variants'
          end
        end
      end
    end

    get '/pg_search_results', to: 'pg_search_results#index'
    get '/elastic_search_results', to: 'elastic_search_results#index'

    post '/charges/create', to: 'charges#create'
  end
end
