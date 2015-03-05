class CreateLeaderships < ActiveRecord::Migration
  def change
    create_table :leaderships do |t|

      t.timestamps
    end
  end
end
