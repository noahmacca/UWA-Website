class FixGiver < ActiveRecord::Migration
  def change
  	rename_column :feedbacks, :giver, :receiver
  end
end
