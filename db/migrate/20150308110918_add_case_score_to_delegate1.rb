class AddCaseScoreToDelegate1 < ActiveRecord::Migration
  def change
  	remove_column :delegates, :case_impact
  	remove_column :delegates, :case_feasibility
  	remove_column :delegates, :case_innovation
  	remove_column :delegates, :case_presentation
  	remove_column :delegates, :case_overall

  	add_column :delegates, :case1_impact, :decimal, :default => 0.0
  	add_column :delegates, :case1_feasibility, :decimal, :default => 0.0
  	add_column :delegates, :case1_innovation, :decimal, :default => 0.0
  	add_column :delegates, :case1_presentation, :decimal, :default => 0.0
  	add_column :delegates, :case1_overall, :decimal, :default => 0.0
  
  	add_column :delegates, :case2_impact, :decimal, :default => 0.0
  	add_column :delegates, :case2_feasibility, :decimal, :default => 0.0
  	add_column :delegates, :case2_innovation, :decimal, :default => 0.0
  	add_column :delegates, :case2_presentation, :decimal, :default => 0.0
  	add_column :delegates, :case2_overall, :decimal, :default => 0.0

  	add_column :delegates, :case3_impact, :decimal, :default => 0.0
  	add_column :delegates, :case3_feasibility, :decimal, :default => 0.0
  	add_column :delegates, :case3_innovation, :decimal, :default => 0.0
  	add_column :delegates, :case3_presentation, :decimal, :default => 0.0
  	add_column :delegates, :case3_overall, :decimal, :default => 0.0

  	add_column :delegates, :case4_impact, :decimal, :default => 0.0
  	add_column :delegates, :case4_feasibility, :decimal, :default => 0.0
  	add_column :delegates, :case4_innovation, :decimal, :default => 0.0
  	add_column :delegates, :case4_presentation, :decimal, :default => 0.0
  	add_column :delegates, :case4_overall, :decimal, :default => 0.0
  end
end
