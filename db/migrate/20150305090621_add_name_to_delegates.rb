class AddNameToDelegates < ActiveRecord::Migration
  def change
    add_column :delegates, :fullname, :string
  end
end
