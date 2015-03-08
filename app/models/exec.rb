class Exec < ActiveRecord::Base
	def self.test1(exec_id, x)
		Exec.where(:id => exec_id).first.position = x
	end
end
