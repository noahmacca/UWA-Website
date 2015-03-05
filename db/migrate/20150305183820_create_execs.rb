class CreateExecs < ActiveRecord::Migration
  def change
    create_table :execs do |t|
      t.string :exec_name
      t.string :team
      t.text :responsibilities
      t.string :program

      t.timestamps
    end
  end
end
