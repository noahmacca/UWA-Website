class AddPresentationDefaultToDelegate < ActiveRecord::Migration
  def change
  	change_column :delegates, :presentation, :integer, :default => 0
  end
end
