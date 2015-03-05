class AddFeedBackIdToDelegate < ActiveRecord::Migration
  def change
    add_column :delegates, :feedback_id, :integer
  end
end
