class CreateCaseByCaseDistinction < ActiveRecord::Migration
  def change
  	remove_column :delegates, :estimated_communication
  	add_column :delegates, :estimated_overall_contribution, :decimal, :default => 0.0
  	remove_column :delegates, :estimated_leadership
  	add_column :delegates, :estimated_leadership, :decimal, :default => 0.0
  	remove_column :delegates, :estimated_business_sense
  	add_column :delegates, :estimated_business_sense, :decimal, :default => 0.0
  	remove_column :delegates, :estimated_creativity
  	add_column :delegates, :estimated_creativity, :decimal, :default => 0.0
  	remove_column :delegates, :estimated_presentation
  	add_column :delegates, :estimated_presentation_skills, :decimal, :default => 0.0

  	remove_column :delegates, :peer_leadership
  	remove_column :delegates, :peer_creativity
  	remove_column :delegates, :peer_business_sense
  	remove_column :delegates, :peer_presentation_skills
  	remove_column :delegates, :peer_overall_contribution
  	remove_column :delegates, :exec_leadership
  	remove_column :delegates, :exec_creativity
  	remove_column :delegates, :exec_business_sense
  	remove_column :delegates, :exec_presentation_skills
  	remove_column :delegates, :exec_overall_contribution
  	remove_column :delegates, :num_peer_evals
  	remove_column :delegates, :num_exec_evals

  	add_column :delegates, :case1_peer_leadership, :decimal, :default => 0.0
  	add_column :delegates, :case1_peer_creativity, :decimal, :default => 0.0
  	add_column :delegates, :case1_peer_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :case1_peer_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :case1_peer_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :case1_exec_leadership, :decimal, :default => 0.0
  	add_column :delegates, :case1_exec_creativity, :decimal, :default => 0.0
  	add_column :delegates, :case1_exec_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :case1_exec_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :case1_exec_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :case1_num_peer_evals, :integer, :default => 0
  	add_column :delegates, :case1_num_exec_evals, :integer, :default => 0

  	add_column :delegates, :case2_peer_leadership, :decimal, :default => 0.0
  	add_column :delegates, :case2_peer_creativity, :decimal, :default => 0.0
  	add_column :delegates, :case2_peer_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :case2_peer_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :case2_peer_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :case2_exec_leadership, :decimal, :default => 0.0
  	add_column :delegates, :case2_exec_creativity, :decimal, :default => 0.0
  	add_column :delegates, :case2_exec_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :case2_exec_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :case2_exec_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :case2_num_peer_evals, :integer, :default => 0
  	add_column :delegates, :case2_num_exec_evals, :integer, :default => 0

  	add_column :delegates, :case3_peer_leadership, :decimal, :default => 0.0
  	add_column :delegates, :case3_peer_creativity, :decimal, :default => 0.0
  	add_column :delegates, :case3_peer_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :case3_peer_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :case3_peer_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :case3_exec_leadership, :decimal, :default => 0.0
  	add_column :delegates, :case3_exec_creativity, :decimal, :default => 0.0
  	add_column :delegates, :case3_exec_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :case3_exec_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :case3_exec_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :case3_num_peer_evals, :integer, :default => 0
  	add_column :delegates, :case3_num_exec_evals, :integer, :default => 0

  	add_column :delegates, :case4_peer_leadership, :decimal, :default => 0.0
  	add_column :delegates, :case4_peer_creativity, :decimal, :default => 0.0
  	add_column :delegates, :case4_peer_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :case4_peer_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :case4_peer_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :case4_exec_leadership, :decimal, :default => 0.0
  	add_column :delegates, :case4_exec_creativity, :decimal, :default => 0.0
  	add_column :delegates, :case4_exec_business_sense, :decimal, :default => 0.0
  	add_column :delegates, :case4_exec_presentation_skills, :decimal, :default => 0.0
  	add_column :delegates, :case4_exec_overall_contribution, :decimal, :default => 0.0
  	add_column :delegates, :case4_num_peer_evals, :integer, :default => 0
  	add_column :delegates, :case4_num_exec_evals, :integer, :default => 0

  end
end
