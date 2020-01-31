class AddAuthTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token, unique: true # Primeiro argumento é a tabela, segundo é o campo
  end
end
