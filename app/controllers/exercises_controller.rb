class ExercisesController < ApplicationController
  before_action :authenticate_user!

  def index
    @units = Unit.all
    @submissions = current_user.submissions
  end

  def create
    begin 
      if params[:exercises][:file].present?
        @submission = Submission.where(user_id: current_user.id, exercise_id: params[:exercises][:exercise_id]).first_or_create(submission_params)
        redirect_to exercises_path
      else
        flash[:danger] = "Something went wrong. Missing file."
        redirect_to root_path
      end
    end
  end

  private 

  def submission_params
    params.require(:exercises).permit(:file, :user_id, :exercise_id)
  end

end
