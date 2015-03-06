class AddLogoToCase < ActiveRecord::Migration
  def change
    add_column :cases, :sponsor_logo, :string
  end
end
