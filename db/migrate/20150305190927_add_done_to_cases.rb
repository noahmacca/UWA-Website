class AddDoneToCases < ActiveRecord::Migration
  def change
    add_column :cases, :done, :boolean, default: false
  end
end
