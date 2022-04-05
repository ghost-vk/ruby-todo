class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.integer :user_id
      t.string :refresh_token

      t.timestamps
    end
  end
end
