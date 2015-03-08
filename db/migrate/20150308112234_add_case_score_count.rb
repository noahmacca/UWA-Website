class AddCaseScoreCount < ActiveRecord::Migration
  def change

  	add_column :Delegates, :case1_eval_count, :integer, :default => 0
  	add_column :Delegates, :case2_eval_count, :integer, :default => 0
  	add_column :Delegates, :case3_eval_count, :integer, :default => 0
  	add_column :Delegates, :case4_eval_count, :integer, :default => 0

  end
end