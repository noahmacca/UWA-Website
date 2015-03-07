class AddEstimatesToDelegate < ActiveRecord::Migration
  def change
  	add_column :delegates, :estimated_leadership, :integer, :default => 0
    add_column :delegates, :estimated_business_sense, :integer, :default => 0
    add_column :delegates, :estimated_communication, :integer, :default => 0
    add_column :delegates, :estimated_creativity, :integer, :default => 0
    add_column :delegates, :estimated_presentation, :integer, :default => 0
  end
end
