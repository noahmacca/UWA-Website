class RenameFeedbackTable < ActiveRecord::Migration
   def change
    rename_column :delegates, :feedback_received, :peer_feeback
  end
end
