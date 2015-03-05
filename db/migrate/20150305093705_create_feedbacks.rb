class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :giver
      t.text :good_comments
      t.text :improvement_comments
      t.integer :leadership
      t.integer :creativity

      t.timestamps
    end
  end
end
