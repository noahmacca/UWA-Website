class AddPictureToExec < ActiveRecord::Migration
  def change
    add_column :execs, :picture, :string
  end
end
