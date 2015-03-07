class AddCaseScoreToDelegate < ActiveRecord::Migration
  def change
  	add_column :delegates, :case_one_score, :integer, :default => 0
    add_column :delegates, :case_two_score, :integer, :default => 0
    add_column :delegates, :case_three_score, :integer, :default => 0
    add_column :delegates, :case_four_score, :integer, :default => 0
  end
end
