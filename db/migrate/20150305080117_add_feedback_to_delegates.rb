class AddFeedbackToDelegates < ActiveRecord::Migration
  def change
    add_column :delegates, :feedback_received, :text
  end
end
