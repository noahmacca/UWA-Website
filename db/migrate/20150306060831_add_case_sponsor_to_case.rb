class AddCaseSponsorToCase < ActiveRecord::Migration
  def change
    add_column :cases, :case_sponsor, :boolean, default: false
  end
end
