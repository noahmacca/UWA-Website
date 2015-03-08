class Delegate < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups
  has_many :feedbacks

  @num_finished_cases = Case.where(:case_sponsor => true).where(:done => true).count 
  
  @Peer_Evals_Weight = 2
  @Exec_Evals_Weight = 3
  @Case_Evals_Weight = 1.5
  @case_pos_weight = 3.5


  ###############
  ### Update average scores. Scores will come from forms that execs and delegates interact with.
  ###############

  # Update Peer and Exec Evaluation Scores
  def self.update_peer_or_exec_scores(eval_type, case_id, d_id, leadership, creativity, business_sense, presentation_skills, overall_contribution)
    # eval_type = 1 if peer evaluation, or 2 if exec evaluation
    # case_id is an integer = 1, 2, 3, or 4
    # This function should work!
    
    temp_delegate = Delegate.where(:id => d_id)

    # This function deals with both peer and exec scores
    if eval_type == 1
      source = "peer"
    elsif evaltype == 2
      source = "exec"
    end

    # Customize the attributes depending on what case number and whether exec or peer review
    dal = ("case" + case_id.to_s + "_" + source + "_leadership").parameterize.underscore.to_sym
    dac = ("case" + case_id.to_s + "_" + source + "_creativity").parameterize.underscore.to_sym
    dabs = ("case" + case_id.to_s + "_" + source + "_business_sense").parameterize.underscore.to_sym
    daps = ("case" + case_id.to_s + "_" + source + "_presentation_skills").parameterize.underscore.to_sym
    daoc = ("case" + case_id.to_s + "_" + source + "_overall_contribution").parameterize.underscore.to_sym
    dacount = ("case" + case_id.to_s + "_num_" + source + "_evals").parameterize.underscore.to_sym
    
    # Need to track the counts to update the averages appropriately
    ### NOTE Not sure if .to_f is a valid command. 
    #     Need to do this because we're using it to multiply the old average, which is a decimal
    old_eval_count = temp_delegate.dacount.to_f
    temp_delegate.dacount += 1

    # Calculate the new average value for each of the five delegate personal attributes
    temp_delegate.dal = (temp_delegate.da1*old_eval_count + leadership)/(old_eval_count + 1.0)
    temp_delegate.dac = (temp_delegate.dac*old_eval_count + creativity)/(old_eval_count + 1.0)
    temp_delegate.dabs = (temp_delegate.dabs*old_eval_count + business_sense)/(old_eval_count + 1.0)
    temp_delegate.daps = (temp_delegate.daps*old_eval_count + presentation_skills)/(old_eval_count + 1.0)
    temp_delegate.daoc = (temp_delegate.daoc*old_eval_count + overall_contribution)/(old_eval_count + 1.0)

  end

  # Case 1: Update Case Evaluation Scores
  def self.update_case_eval_scores(d_id, case_id, impact, feasibility, innovation, presentation, overall)
    # This function should work!
    temp_delegate = Delegate.where(:id => d_id)

    dcim = ("case" + case_id.to_s + "_impact").parameterize.underscore.to_sym
    dcf = ("case" + case_id.to_s + "_feasibility").parameterize.underscore.to_sym
    dcin = ("case" + case_id.to_s + "_innovation").parameterize.underscore.to_sym
    dcp = ("case" + case_id.to_s + "_presentation").parameterize.underscore.to_sym
    dco = ("case" + case_id.to_s + "_overall").parameterize.underscore.to_sym
    dccount = ("case" + case_id.to_s + "_eval_count").parameterize.underscore.to_sym

    old_eval_count = temp_delegate.dccount.to_f
    temp_delegate.dccount += 1

    temp_delegate.dcim = (temp_delegate.dcim*old_eval_count + impact)/(old_eval_count + 1.0)
    temp_delegate.dcf = (temp_delegate.dcf*old_eval_count + feasibility)/(old_eval_count + 1.0)
    temp_delegate.dcin = (temp_delegate.dcin*old_eval_count + innovation)/(old_eval_count + 1.0)
    temp_delegate.dcp = (temp_delegate.dcp*old_eval_count + presentation)/(old_eval_count + 1.0)
    temp_delegate.dco = (temp_delegate.dco*old_eval_count + overall)/(old_eval_count + 1.0)

  end
  
  # Update Case Position Scores
  def self.update_case_pos_scores(case_number, case_position)
    # This function should work!
    if case_number == 1
      case_one_score = (case_position/x)*50
    elsif case_number == 2
      case_two_score = (case_position/x)*50
    elsif case_number == 3
      case_three_score = (case_position/x)*50
    elsif case_number == 4
      case_three_score = (case_position/x)*50
    end
  end


  ###############
  ### Old functions are below
  ###############

  def self.pending_feedback(d_id)
	num_reviewing = 3 
	given_feedback = Feedback.where(:delegate_id => d_id.id).count

	(@num_finished_cases * num_reviewing) - given_feedback
  end

  def self.received_feedback(d_id)
  	Feedback.where(:receiver => d_id).count
  end

  # criteria must be a string
  # Can return the top x delegates that satisfy a given point category criterion
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

  def self.conference_score()
  end

  def self.case_eval_score(impact, feasibility, innovation, presentation, overall)
  	(impact +  feasibility + innovation + presentation + overall) / @num_finished_cases
  end

  def self.case_criteria_score(params)

    # Array keeping scores of c1...c4
    case_scores = [0,0,0,0]

    #if (@num_finished_cases == 1)

     # case_scores[]

  end


end
