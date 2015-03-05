class AddDelegateIdToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :delegate_id, :integer
  end
end
