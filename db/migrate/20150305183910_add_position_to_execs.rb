class AddPositionToExecs < ActiveRecord::Migration
  def change
    add_column :execs, :position, :string
  end
end
