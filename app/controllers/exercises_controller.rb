class ExercisesController < ApplicationController
  before_action :authenticate_user!

  def index
    @units = Unit.all
    @submissions = current_user.submissions
    #logger.debug "######### Submission - #{@submissions.where(exercise_id: 2).first.file.attached?}   #################"
  end

  def create
    @submission = Submission.where(user_id: current_user.id, exercise_id: params[:exercises][:exercise_id]).first_or_create(submission_params)
    logger.debug "DEBUG - submission: #{@submission.id} - user: #{@submission.user.id}"
    redirect_to exercises_path
  end

  private 

  def submission_params
    params.require(:exercises).permit(:file, :user_id, :exercise_id)
  end

end
