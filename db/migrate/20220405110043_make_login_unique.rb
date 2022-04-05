class MakeLoginUnique < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :login, :string, unique: true
  end
end
