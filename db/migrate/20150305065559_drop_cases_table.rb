class DropCasesTable < ActiveRecord::Migration
 def up
    drop_table :cases
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
