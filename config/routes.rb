require 'api_version_constraint'
Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :users, only: [:show, :create]
    end
  end
end


# namespace :api => Cria um caminho para acessar aque controller ex: www.localhost:3000/api
# defaults: { format: :json } => Diz que o formato da saida é json
# constraints: { subdomain: 'api' } => Diz que so pode entrar no bloco se tiver um sub dominio 'api'
# path: "/" => Troca o 'www.localhost:3000/api' para somente www.localhost:3000/ que é o root