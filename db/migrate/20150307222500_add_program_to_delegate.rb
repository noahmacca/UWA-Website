class AddProgramToDelegate < ActiveRecord::Migration
  def change
    add_column :delegates, :delegate_program, :string
  end
end
