class AddUserIdToTokens < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :tokens, :users
  end
end
