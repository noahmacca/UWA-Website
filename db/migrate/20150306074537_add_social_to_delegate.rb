class AddSocialToDelegate < ActiveRecord::Migration
  def change
    add_column :delegates, :linkedin, :string
    add_column :delegates, :facebook, :string
    add_column :delegates, :twitter, :string
  end
end
