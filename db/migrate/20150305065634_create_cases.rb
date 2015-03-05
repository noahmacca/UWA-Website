class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :title
      t.string :sponsor
      t.text :description

      t.timestamps
    end
  end
end
