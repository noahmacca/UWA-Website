class AddEndToItinerary < ActiveRecord::Migration
  def change
  	add_column :itineraries, :item_time_end, :time
  end
end
