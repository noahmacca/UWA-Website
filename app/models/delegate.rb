class Delegate < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups
  has_many :feedbacks

  @num_finished_cases = Case.where(:case_sponsor => true).where(:done => true).count 

  def self.case_or_exec_score(leadership, creativity, business_sense, presentation, contribution)
  	(leadership + creativity + business_sense + presentation + contribution) / @num_finished_cases
  end

  def self.pending_feedback(d_id)
	num_reviewing = 3 
	given_feedback = Feedback.where(:delegate_id => d_id.id).count

	(@num_finished_cases * num_reviewing) - given_feedback
  end

  def self.received_feedback(d_id)
  	Feedback.where(:receiver => d_id).count
  end


  def self.avg_top_x(criteria, x)

  	criteria_sym = criteria.parameterize.underscore.to_sym
  	if Delegate.count > x
  	top_x = Delegate.order(criteria_sym).limit(x)

  	sum = 0
  	top_x.each do |t|

  		sum += t[criteria_sym]

  	end

  	sum / x

  else
  	Delegate.first[criteria_sym]

  end

  end

  def self.conference_score

  end

  def self.case_eval_score(impact, feasibility, innovation, presentation, overall)
  	(impact +  feasibility + innovation + presentation + overall) / @num_finished_cases
  end

  def self.case_score(case_eval, case_w_score)

  	

  end

end
