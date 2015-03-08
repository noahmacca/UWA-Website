class AddSubmissionCountTracking1 < ActiveRecord::Migration
  def change
  	add_column :delegates, :num_peer_evals, :integer, :default => 0
  	add_column :delegates, :num_exec_evals, :integer, :default => 0
  	add_column :delegates, :num_complete_cases, :integer, :default => 0
  end
end
