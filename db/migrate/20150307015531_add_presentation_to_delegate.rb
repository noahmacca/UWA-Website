class AddPresentationToDelegate < ActiveRecord::Migration
  def change
    add_column :delegates, :presentation, :integer
  end
end
