class CreateDelegatesGroupJoin < ActiveRecord::Migration

	def self.up
		create_table 'delegates_groups', :id => false do |t|
			t.column 'delegate_id', :integer
			t.column 'group_id', :integer
		end
	end

	def self.down
		drop_table 'delegates_groups'
	end

end
