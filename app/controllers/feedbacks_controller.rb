class FeedbacksController < ApplicationController
before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @feedbacks = Feedback.all
    respond_with(@feedbacks)
  end

  def show
    respond_with(@feedback)
  end

  def new
    #@feedback = Feedback.new

    # See the feedback you've given
    @feedback = current_delegate.feedbacks.build
    respond_with(@feedback)
  end

  def edit
  end

  def create
    @feedback = current_delegate.feedbacks.build(feedback_params)
    @feedback.save
    respond_with(@feedback)
  end

  def update
    @feedback.update(feedback_params)
    respond_with(@feedback)
  end

  def destroy
    @feedback.destroy
    respond_with(@feedback)
  end
  private
  def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def feedback_params
      params.require(:feedback).permit(:giver, :good_comments, :improvement_comments, :leadership, :creativity)
    end
end

