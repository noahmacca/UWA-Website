class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string :item
      t.time :item_time
      t.string :day

      t.timestamps
    end
  end
end
