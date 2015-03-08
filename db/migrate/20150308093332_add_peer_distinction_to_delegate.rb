class AddPeerDistinctionToDelegate < ActiveRecord::Migration
  def change
  	add_column :delegates, :peer_leadership, :decimal, :default => 0.0
  	add_column :delegates, :peer_creativity, :decimal, :default => 0.0
  	add_column :delegates, :peer_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :peer_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :peer_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :exec_leadership, :decimal, :default => 0.0
  	add_column :delegates, :exec_creativity, :decimal, :default => 0.0
  	add_column :delegates, :exec_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :exec_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :exec_overall_contribution, :decimal, :default => 0.0

  	add_column :delegates, :num_peer_evals, :integer, :default => 0
  	add_column :delegates, :num_exec_evals, :integer, :default => 0
  	add_column :delegates, :num_complete_cases, :integer, :default => 0

  	remove_column :delegates, :presentation
  	remove_column :delegates, :leadership
  	remove_column :delegates, :business_sense
  	remove_column :delegates, :communication
  	remove_column :delegates, :creativity

  end
end
