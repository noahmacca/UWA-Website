class AddSkillsToDelegate < ActiveRecord::Migration
  def change
    add_column :delegates, :leadership, :integer, :default => 0
    add_column :delegates, :business_sense, :integer, :default => 0
    add_column :delegates, :communication, :integer, :default => 0
    add_column :delegates, :creativity, :integer, :default => 0
    add_column :delegates, :case_wins, :integer, :default => 0
    add_column :delegates, :total_score, :decimal, :default => 0
  end
end
