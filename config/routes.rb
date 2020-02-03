require 'api_version_constraint'
Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: {sessions: 'api/v1/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1) do
      resources :users, only: [:show, :create, :update, :destroy] # Esse é um formato de um CRUD 'show' = GET, 'create' = POST, 'update' = PUT, 'destroy' = DELETE
      resources :sessions, only: [:create, :destroy]
      resources :tasks, only: [:index, :show, :create, :update, :destroy] # 'index' siginifica um array contendo varias tarefas
    end

    namespace :v2, path: '/', constraints: ApiVersionConstraint.new(version: 2, default: true) do
      resources :users, only: [:show, :create, :update, :destroy] # Esse é um formato de um CRUD 'show' = GET, 'create' = POST, 'update' = PUT, 'destroy' = DELETE
      resources :sessions, only: [:create, :destroy]
      resources :tasks, only: [:index, :show, :create, :update, :destroy] # 'index' siginifica um array contendo varias tarefas
    end
  end
end


# namespace :api => Cria um caminho para acessar aque controller ex: www.localhost:3000/api
# defaults: { format: :json } => Diz que o formato da saida é json
# constraints: { subdomain: 'api' } => Diz que so pode entrar no bloco se tiver um sub dominio 'api'
# path: "/" => Troca o 'www.localhost:3000/api' para somente www.localhost:3000/ que é o root