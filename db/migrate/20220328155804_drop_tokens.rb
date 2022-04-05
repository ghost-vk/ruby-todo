class DropTokens < ActiveRecord::Migration[7.0]
  def up
    drop_table :tokens
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
