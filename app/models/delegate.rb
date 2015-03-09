class Delegate < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups
  has_many :feedbacks

  @num_finished_cases = Case.where(:case_sponsor => true).where(:done => true).count 
  
  @peer_evals_weight = 4.0
  @exec_evals_weight = 6.0
  @case_evals_weight = 3.0
  @case_pos_weight = 7.0
  @raw_max = 50

  ###############
  ### Update average scores. Scores will come from forms that execs and delegates interact with.
  ###############

  # Update Peer and Exec Evaluation Scores
  def self.update_peer_or_exec_scores(eval_type, case_id, d_id, leadership, creativity, business_sense, presentation_skills, overall_contribution)
    # eval_type = 1 if peer evaluation, or 2 if exec evaluation
    # case_id is an integer = 1, 2, 3, or 4
    # This function should work!
    
    temp_delegate = Delegate.where(:id => d_id).first

    # This function deals with both peer and exec scores
    if eval_type == 1
      source = "peer"
    elsif eval_type == 2
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
    old_eval_count = temp_delegate[dacount].to_f
    temp_delegate[dacount] += 1

    # Calculate the new average value for each of the five delegate personal attributes
    temp_delegate[dal] = (temp_delegate[dal]*old_eval_count + leadership)/(old_eval_count + 1.0)
    temp_delegate[dac] = (temp_delegate[dac]*old_eval_count + creativity)/(old_eval_count + 1.0)
    temp_delegate[dabs] = (temp_delegate[dabs]*old_eval_count + business_sense)/(old_eval_count + 1.0)
    temp_delegate[daps] = (temp_delegate[daps]*old_eval_count + presentation_skills)/(old_eval_count + 1.0)
    temp_delegate[daoc] = (temp_delegate[daoc]*old_eval_count + overall_contribution)/(old_eval_count + 1.0)

    temp_delegate.save!

  end


  # Update Case Evaluation Scores
  def self.update_case_eval_scores(d_id, case_id, impact, feasibility, innovation, presentation, overall)
    # This function should work!
    temp_delegate = Delegate.where(:id => d_id).first

    dcim = ("case" + case_id.to_s + "_impact").parameterize.underscore.to_sym
    dcf = ("case" + case_id.to_s + "_feasibility").parameterize.underscore.to_sym
    dcin = ("case" + case_id.to_s + "_innovation").parameterize.underscore.to_sym
    dcp = ("case" + case_id.to_s + "_presentation").parameterize.underscore.to_sym
    dco = ("case" + case_id.to_s + "_overall").parameterize.underscore.to_sym
    dccount = ("case" + case_id.to_s + "_eval_count").parameterize.underscore.to_sym

    old_eval_count = temp_delegate[dccount].to_f
    temp_delegate[dccount] += 1

    temp_delegate[dcim] = (temp_delegate[dcim]*old_eval_count + impact)/(old_eval_count + 1.0)
    temp_delegate[dcf] = (temp_delegate[dcf]*old_eval_count + feasibility)/(old_eval_count + 1.0)
    temp_delegate[dcin] = (temp_delegate[dcin]*old_eval_count + innovation)/(old_eval_count + 1.0)
    temp_delegate[dcp] = (temp_delegate[dcp]*old_eval_count + presentation)/(old_eval_count + 1.0)
    temp_delegate[dco] = (temp_delegate[dco]*old_eval_count + overall)/(old_eval_count + 1.0)

    temp_delegate.save!

  end

  
  # Update Case Position Scores
  def self.update_case_pos_scores(d_id, case_number, case_position)

    temp_delegate = Delegate.where(:id => d_id).first

    case1score = ("case_one_score").parameterize.underscore.to_sym
    case2score = ("case_two_score").parameterize.underscore.to_sym
    case3score = ("case_three_score").parameterize.underscore.to_sym
    case4score = ("case_four_score").parameterize.underscore.to_sym

    discount_factor = 1/(case_position.to_f)

    if case_position <= 3
      if case_number == 1
        temp_delegate[case1score] = discount_factor*@raw_max
      elsif case_number == 2
        temp_delegate[case2score] = discount_factor*@raw_max
      elsif case_number == 3
        temp_delegate[case3score] = discount_factor*@raw_max
      elsif case_number == 4
        temp_delegate[case4score] = discount_factor*@raw_max
      end
    else
      if case_number == 1
        temp_delegate[case1score] = 0
      elsif case_number == 2
        temp_delegate[case2score] = 0
      elsif case_number == 3
        temp_delegate[case3score] = 0
      elsif case_number == 4
        temp_delegate[case4score] = 0
      end
    end

    temp_delegate.save!
  end

  #################
  ### Summary of Plot inputs/outputs
  #################
  ###############
  ### Plot 1: Individual Attribute Scores
  ###   Average the scores across all of the complete cases, and execs/peer evals
  ###############

  # Todo: test
  # This at least has a logical output
  def self.average_delegate_attribute_scores(d_id)
    temp_delegate = Delegate.where(:id => d_id).first
    completed_cases = @num_finished_cases
  
    # This function deals with both peer and exec scores
    type_peer = "peer"
    type_exec = "exec"

    # Store the attributes in variables
    att_l = "_leadership"
    att_c = "_creativity"
    att_bs = "_business_sense"
    att_ps = "_presentation_skills"
    att_oc = "_overall_contribution"

    #First, average the scores of the execs across all completed cases
      # Initialize all of the totals to calculate
      total_exec_l = 0
      total_exec_c = 0
      total_exec_bs = 0
      total_exec_ps = 0
      total_exec_oc = 0

      avg_exec_l = 0
      avg_exec_c = 0
      avg_exec_bs = 0
      avg_exec_ps = 0
      avg_exec_oc = 0

      #leadership
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_exec + att_l).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_exec_l += temp_score
      end
      avg_exec_l = total_exec_l/completed_cases

      #creativity
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_exec + att_c).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_exec_c += temp_score
      end
      avg_exec_c = total_exec_c/completed_cases

      #business sense
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_exec + att_bs).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_exec_bs += temp_score
      end
      avg_exec_bs = total_exec_bs/completed_cases

      #presentation skills
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_exec + att_ps).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_exec_ps += temp_score
      end
      avg_exec_ps = total_exec_ps/completed_cases

      #overall contribution
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_exec + att_oc).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_exec_oc += temp_score
      end
      avg_exec_oc = total_exec_oc/completed_cases

    #Second, average the score of the peers across all completed cases
      # Initialize all of the totals to calculate
      total_peer_l = 0
      total_peer_c = 0
      total_peer_bs = 0
      total_peer_ps = 0
      total_peer_oc = 0

      avg_peer_l = 0
      avg_peer_c = 0
      avg_peer_bs = 0
      avg_peer_ps = 0
      avg_peer_oc = 0

      #leadership
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_peer + att_l).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_peer_l += temp_score
      end
      avg_peer_l = total_peer_l/completed_cases

      #creativity
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_peer + att_c).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_peer_c += temp_score
      end
      avg_peer_c = total_peer_c/completed_cases

      #business sense
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_peer + att_bs).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_peer_bs += temp_score
      end
      avg_peer_bs = total_peer_bs/completed_cases

      #presentation skills
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_peer + att_ps).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_peer_ps += temp_score
      end
      avg_peer_ps = total_peer_ps/completed_cases

      #overall contribution
      for i in 1..4
        temp_attribute = ("case" + i.to_s + "_" + type_peer + att_oc).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_peer_oc += temp_score
      end
      avg_peer_oc = total_peer_oc/completed_cases

    #Third, average the score of the peers and execs for each metric
    avg_l = (avg_exec_l + avg_peer_l)/2
    avg_c = (avg_exec_c + avg_peer_c)/2
    avg_bs = (avg_exec_bs + avg_peer_bs)/2
    avg_ps = (avg_exec_ps + avg_peer_ps)/2
    avg_oc = (avg_exec_oc + avg_peer_oc)/2

    return average_delegate_attribute_scores = [avg_l, avg_c, avg_bs, avg_ps, avg_oc]
    # return average_delegate_attribute_scores[avg_leadership, avg_creativity, avg_business_sense, avg_presentation_skills, avg_overall_contributions]

  end
  
  ###############
  ### Plot 2: Case Attribute Scores
  ###   Average the scores across all of the complete cases.
  ###############
  def self.average_case_eval_scores(d_id)
    temp_delegate = Delegate.where(:id => d_id).first
    completed_cases = @num_finished_cases

    # Store the attributes in variables
    att_im = "_impact"
    att_f = "_feasibility"
    att_in = "_innovation"
    att_p = "_presentation"
    att_o = "_overall"

    #First, average the scores of the execs across all completed cases
      # Initialize all of the totals to calculate
      total_im = 0
      total_f = 0
      total_in = 0
      total_p = 0
      total_o = 0

      avg_im = 0
      avg_f = 0
      avg_in = 0
      avg_p = 0
      avg_o = 0

      #impact
      for i in 1..4
        temp_attribute = ("case" + i.to_s + att_im).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_im += temp_score
      end
      avg_im = total_im/completed_cases

      #feasibility
      for i in 1..4
        temp_attribute = ("case" + i.to_s + att_f).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_f += temp_score
      end
      avg_f = total_f/completed_cases

      #innovation
      for i in 1..4
        temp_attribute = ("case" + i.to_s + att_in).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_in += temp_score
      end
      avg_in = total_in/completed_cases

      #presentation
      for i in 1..4
        temp_attribute = ("case" + i.to_s + att_p).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_p += temp_score
      end
      avg_p = total_p/completed_cases

      #overall
      for i in 1..4
        temp_attribute = ("case" + i.to_s + att_o).parameterize.underscore.to_sym
        temp_score = temp_delegate[temp_attribute]
        total_o += temp_score
      end
      avg_o = total_o/completed_cases

      return average_case_eval_scores_output = [avg_im, avg_f, avg_in, avg_p, avg_o]
  end

  ###############
  ### Plot 3: Point Breakdown by source
  ###   Calculate the total, weighted points from peer evals, exec evals, case evals, and case position. Calculate SD if possible.
  ###############
  def self.total_points_by_source(d_id)
    temp_delegate = Delegate.where(:id => d_id).first
    completed_cases = @num_finished_cases
  
    # This function deals with both peer and exec scores
    type_peer = "peer"
    type_exec = "exec"

    # Store the delegate attributes in variables
    att_l = "_leadership"
    att_c = "_creativity"
    att_bs = "_business_sense"
    att_ps = "_presentation_skills"
    att_oc = "_overall_contribution"

    # Store the case attributes in variables
    att_im = "_impact"
    att_f = "_feasibility"
    att_in = "_innovation"
    att_p = "_presentation"
    att_o = "_overall"

    # First, average the scores of the execs across all completed cases
      # Initialize all of the totals to calculate
      raw_exec_score_sum = 0
      raw_peer_score_sum = 0
      raw_case_eval_score_sum = 0
      raw_case_pos_score = 0

    #First, average the scores of the execs across all completed cases
      # raw exec delegate attribute score
      for i in 1..4
        temp_l = ("case" + i.to_s + "_" + type_exec + att_l).parameterize.underscore.to_sym
        temp_c = ("case" + i.to_s + "_" + type_exec + att_c).parameterize.underscore.to_sym
        temp_bs = ("case" + i.to_s + "_" + type_exec + att_bs).parameterize.underscore.to_sym
        temp_ps = ("case" + i.to_s + "_" + type_exec + att_ps).parameterize.underscore.to_sym
        temp_oc = ("case" + i.to_s + "_" + type_exec + att_oc).parameterize.underscore.to_sym

        temp_score_l = temp_delegate[temp_l]
        temp_score_c = temp_delegate[temp_c]
        temp_score_bs = temp_delegate[temp_bs]
        temp_score_ps = temp_delegate[temp_ps]
        temp_score_oc = temp_delegate[temp_oc]

        temp_case_score_total = temp_score_l + temp_score_c + temp_score_bs + temp_score_ps + temp_score_oc
        raw_exec_score_sum += temp_case_score_total

      end

      # raw peer delegate attribute score
      for i in 1..4
        temp_l = ("case" + i.to_s + "_" + type_peer + att_l).parameterize.underscore.to_sym
        temp_c = ("case" + i.to_s + "_" + type_peer + att_c).parameterize.underscore.to_sym
        temp_bs = ("case" + i.to_s + "_" + type_peer + att_bs).parameterize.underscore.to_sym
        temp_ps = ("case" + i.to_s + "_" + type_peer + att_ps).parameterize.underscore.to_sym
        temp_oc = ("case" + i.to_s + "_" + type_peer + att_oc).parameterize.underscore.to_sym

        temp_score_l = temp_delegate[temp_l]
        temp_score_c = temp_delegate[temp_c]
        temp_score_bs = temp_delegate[temp_bs]
        temp_score_ps = temp_delegate[temp_ps]
        temp_score_oc = temp_delegate[temp_oc]

        temp_case_score_total = temp_score_l + temp_score_c + temp_score_bs + temp_score_ps + temp_score_oc
        raw_peer_score_sum += temp_case_score_total
      end

      # raw case eval score
      for i in 1..4
        temp_im = ("case" + i.to_s + att_im).parameterize.underscore.to_sym
        temp_f = ("case" + i.to_s + att_f).parameterize.underscore.to_sym
        temp_in = ("case" + i.to_s + att_in).parameterize.underscore.to_sym
        temp_p = ("case" + i.to_s + att_p).parameterize.underscore.to_sym
        temp_o = ("case" + i.to_s + att_o).parameterize.underscore.to_sym

        temp_score_im = temp_delegate[temp_im]
        temp_score_f = temp_delegate[temp_f]
        temp_score_in = temp_delegate[temp_in]
        temp_score_p = temp_delegate[temp_p]
        temp_score_o = temp_delegate[temp_o]

        temp_case_score_total = temp_score_im + temp_score_f + temp_score_in + temp_score_p + temp_score_o
        raw_case_eval_score_sum += temp_case_score_total
      end

      # raw case position score
      case1score = ("case_one_score").parameterize.underscore.to_sym
      case2score = ("case_two_score").parameterize.underscore.to_sym
      case3score = ("case_three_score").parameterize.underscore.to_sym
      case4score = ("case_four_score").parameterize.underscore.to_sym

      raw_case_pos_score = temp_delegate[case1score] + temp_delegate[case2score] + temp_delegate[case3score] + temp_delegate[case4score]

      # Apply weight factors
      weighted_exec_score = raw_exec_score_sum * @exec_evals_weight
      weighted_peer_score = raw_peer_score_sum * @peer_evals_weight
      weighted_case_eval_score = raw_case_eval_score_sum * @case_evals_weight
      weighted_case_pos_score = raw_case_pos_score * @case_pos_weight

      conference_score = weighted_exec_score + weighted_peer_score + weighted_case_eval_score + weighted_case_pos_score
      temp_delegate.total_score = conference_score
      temp_delegate.save!

      # return total_points_by_source_output[peer scores, exec scores, case eval scores, case pos scores]  
      return total_points_by_source_output = [weighted_peer_score, weighted_exec_score, weighted_case_eval_score, weighted_case_pos_score]
  end

  ###############
  ### Plot 4: Points achieved per case
  ###   This requires finding the number of points for a given category and case, and plotting them in a stacked bar graph
  ###############
  def self.total_points_by_case(d_id, case_number)
    temp_delegate = Delegate.where(:id => d_id).first
    completed_cases = @num_finished_cases
    case_num = case_number.to_s
  
    # This function deals with both peer and exec scores
    type_peer = "peer"
    type_exec = "exec"

    # Store the delegate attributes in variables
    att_l = "_leadership"
    att_c = "_creativity"
    att_bs = "_business_sense"
    att_ps = "_presentation_skills"
    att_oc = "_overall_contribution"

    # Store the case attributes in variables
    att_im = "_impact"
    att_f = "_feasibility"
    att_in = "_innovation"
    att_p = "_presentation"
    att_o = "_overall"


    # Initialize all of the totals to calculate
    raw_exec_score_sum = 0
    raw_peer_score_sum = 0
    raw_case_eval_score_sum = 0
    raw_case_pos_score = 0

    # raw exec delegate attribute score
      temp_e_l = ("case" + case_num + "_" + type_exec + att_l).parameterize.underscore.to_sym
      temp_e_c = ("case" + case_num + "_" + type_exec + att_c).parameterize.underscore.to_sym
      temp_e_bs = ("case" + case_num + "_" + type_exec + att_bs).parameterize.underscore.to_sym
      temp_e_ps = ("case" + case_num + "_" + type_exec + att_ps).parameterize.underscore.to_sym
      temp_e_oc = ("case" + case_num + "_" + type_exec + att_oc).parameterize.underscore.to_sym

      temp_e_score_l = temp_delegate[temp_e_l]
      temp_e_score_c = temp_delegate[temp_e_c]
      temp_e_score_bs = temp_delegate[temp_e_bs]
      temp_e_score_ps = temp_delegate[temp_e_ps]
      temp_e_score_oc = temp_delegate[temp_e_oc]

      raw_exec_score_sum = temp_e_score_l + temp_e_score_c + temp_e_score_bs + temp_e_score_ps + temp_e_score_oc
    
    # raw peer delegate attribute score
      temp_p_l = ("case" + case_num + "_" + type_peer + att_l).parameterize.underscore.to_sym
      temp_p_c = ("case" + case_num + "_" + type_peer + att_c).parameterize.underscore.to_sym
      temp_p_bs = ("case" + case_num + "_" + type_peer + att_bs).parameterize.underscore.to_sym
      temp_p_ps = ("case" + case_num + "_" + type_peer + att_ps).parameterize.underscore.to_sym
      temp_p_oc = ("case" + case_num + "_" + type_peer + att_oc).parameterize.underscore.to_sym

      temp_p_score_l = temp_delegate[temp_p_l]
      temp_p_score_c = temp_delegate[temp_p_c]
      temp_p_score_bs = temp_delegate[temp_p_bs]
      temp_p_score_ps = temp_delegate[temp_p_ps]
      temp_p_score_oc = temp_delegate[temp_p_oc]

      raw_peer_score_sum = temp_p_score_l + temp_p_score_c + temp_p_score_bs + temp_p_score_ps + temp_p_score_oc

    # raw case eval score
      temp_im = ("case" + case_num + att_im).parameterize.underscore.to_sym
      temp_f = ("case" + case_num + att_f).parameterize.underscore.to_sym
      temp_in = ("case" + case_num + att_in).parameterize.underscore.to_sym
      temp_p = ("case" + case_num + att_p).parameterize.underscore.to_sym
      temp_o = ("case" + case_num + att_o).parameterize.underscore.to_sym

      temp_score_im = temp_delegate[temp_im]
      temp_score_f = temp_delegate[temp_f]
      temp_score_in = temp_delegate[temp_in]
      temp_score_p = temp_delegate[temp_p]
      temp_score_o = temp_delegate[temp_o]

      raw_case_eval_score_sum = temp_score_im + temp_score_f + temp_score_in + temp_score_p + temp_score_o

     # raw case position score
      if case_num == "1"
        casescore = ("case_one_score").parameterize.underscore.to_sym
      elsif case_num == "2" 
        casescore = ("case_two_score").parameterize.underscore.to_sym
      elsif case_num == "3"
        casescore = ("case_three_score").parameterize.underscore.to_sym
      elsif case_num == "4"
        casescore = ("case_four_score").parameterize.underscore.to_sym
      end

      raw_case_pos_score = temp_delegate[casescore]

    # Apply weight factors
      weighted_exec_score = raw_exec_score_sum * @exec_evals_weight
      weighted_peer_score = raw_peer_score_sum * @peer_evals_weight
      weighted_case_eval_score = raw_case_eval_score_sum * @case_evals_weight
      weighted_case_pos_score = raw_case_pos_score * @case_pos_weight

    # return total_points_by_source_output[peer scores, exec scores, case eval scores, case pos scores]  
      return total_points_by_source_output = [weighted_peer_score, weighted_exec_score, weighted_case_eval_score, weighted_case_pos_score]
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

  # This shold return max scores in form: [peer_evals, exec_evals, case_eval, case_position]

  def self.max_values

    scores = [0,0,0,0]

    scores[0] = @raw_max * @peer_evals_weight * @num_finished_cases
    scores[1] = @raw_max * @exec_evals_weight * @num_finished_cases
    scores[2] = @raw_max * @case_evals_weight * @num_finished_cases
    scores[3] = @raw_max * @case_pos_weight * @num_finished_cases

    return scores
  end


end
