module ApplicationHelper

	def cp(path)
  "active" if current_page?(path)
	end

	def status(type, value)
		if type == 'pending_feedback'
			value == 0 ? "good" : "danger"
			end
		end
end
