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
  ### Plot 1: Individual Attribute Scores
  ###   Average the scores across all of the complete cases, and execs/peer evals
  ###############
  def self.average_delegate_attribute_scores(d_id)
    temp_delegate = Delegate.where(:id => d_id)


    ### Todo Please add the other attributes to this function
    #First, average the scores of the execs across all completed cases
      avg_exec_leadership = (temp_delegate.case1_exec_leadership + temp_delegate.case2_exec_leadership + ...
        temp_delegate.case3_exec_leadership + temp_delegate.case4_exec_leadership)/temp_delegate.num_completed_cases

    #Second, average the score of the peers across all completed cases
    avg_peer_leadership = (temp_delegate.case1_peer_leadership + temp_delegate.case2_peer_leadership + ...
        temp_delegate.case3_peer_leadership + temp_delegate.case4_peer_leadership)/temp_delegate.num_completed_cases

    #Third, average the score of the peers and execs for each metric
    avg_leadership = (avg_exec_leadership + avg_peer_leadership)/2

    #Repeat for creativity, business_sense, presentation_skills, overall_contribution

  end

  ###############
  ### Plot 2: Case Attribute Scores
  ###   Average the scores across all of the complete cases.
  ###############
  def self.average_case_eval_scores(d_id)
    temp_delegate = Delegate.where(:id => d_id)
    
    #Metrics: impact, feasibility, innovation, presentation, overall
    avg_impact = (temp_delegate.case1_impact + temp_delegate.case2_impact + ...
      temp_delegate.case3_impact + temp_delegate.case4_impact)/temp_delegate.num_completed_cases

    avg_feasibility = (temp_delegate.case1_feasibility + temp_delegate.case2_feasibility + ...
      temp_delegate.case3_feasibility + temp_delegate.case4_feasibility)/temp_delegate.num_completed_cases

    avg_innovation = (temp_delegate.case1_innovation + temp_delegate.case2_innovation + ...
      temp_delegate.case3_innovation + temp_delegate.case4_innovation)/temp_delegate.num_completed_cases

    avg_presentation = (temp_delegate.case1_presentation + temp_delegate.case2_presentation + ...
      temp_delegate.case3_presentation + temp_delegate.case4_presentation)/temp_delegate.num_completed_cases

    avg_overall = (temp_delegate.case1_overall + temp_delegate.case2_overall + ...
      temp_delegate.case3_overall + temp_delegate.case4_overall)/temp_delegate.num_completed_cases
  end


  ###############
  ### Calculate the values to be displayed in Plot 3: Point Breakdown by source
  ###   Calculate the total, weighted points from peer evals, exec evals, case evals, and case position. Calculate SD if possible.
  ###############
  def self.total_points_by_source(d_id)
    temp_delegate = Delegate.where(:id => d_id)
      
    # Sum the average attribute score across all cases, 
    peer_points_unweighted = (case1_peer_leadership + case1_peer_creativity + ...) + (case2_peer_leadership + case2_peer_creativity + ...) + ...
    exec_points_unweighted = 
    case_eval_points_unweighted = 
    case_pos_scores_unweighted = case_one_score + case_two_score + case_three_score + case_four_score

    # Apply weight factors
    peer_points_weighted = peer_points_unweights * @Peer_Evals_Weight
    exec_points_weighted = exec_points_unweighted * @Exec_Evals_Weight
    case_eval_points_weighted = case_eval_points_unweighted * @case_pos_weight
    case_pos_scores_weighted = case_pos_scores_unweighted * @case_pos_weight
  end


  ###############
  ### Calculate the values to be displayed in Plot 4: Points achieved per case
  ###   This requires finding the number of points for a given category and case, and plotting them in a stacked bar graph
  ###############
  def selc.total_points_by_case(d_id)
    temp_delegate = Delegate.where(:id => d_id)
    # Sum the scores for a given case number and source (will be a value out of 50, e.g. for case 1 peer evaluations)


    # Multiply this sum by the appropriate weight factor


    # You now have the number of points obtained from each category and for each case. These can be plotted on a stacked bar graph.


    
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

  def self.conference_score

  end

  def self.case_eval_score(impact, feasibility, innovation, presentation, overall)
  	(impact +  feasibility + innovation + presentation + overall) / @num_finished_cases
  end

  def self.case_criteria_score(impact, feasibility, innovation, presentation, overall)

    # Array keeping scores of c1...c4
    case_scores = [0,0,0,0]

    #if (@num_finished_cases == 1)

     # case_scores[]


  end


end
