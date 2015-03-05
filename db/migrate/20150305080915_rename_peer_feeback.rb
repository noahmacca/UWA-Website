class RenamePeerFeeback < ActiveRecord::Migration
  def change
    rename_column :delegates, :peer_feeback, :peer_feedback_received
  end
end
