class AddAttachmentToCases < ActiveRecord::Migration
  def change
  	add_attachment :cases, :document
  end
end
