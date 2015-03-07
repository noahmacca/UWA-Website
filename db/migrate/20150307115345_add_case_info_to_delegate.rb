class AddCaseInfoToDelegate < ActiveRecord::Migration
  def change
  	add_column :delegates, :case_impact, :integer, :default => 0
    add_column :delegates, :case_feasibility, :integer, :default => 0
    add_column :delegates, :case_innovation, :integer, :default => 0
    add_column :delegates, :case_presentation, :integer, :default => 0
    add_column :delegates, :case_overall, :integer, :default => 0
  end
end
