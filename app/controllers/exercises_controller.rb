class ExercisesController < ApplicationController
  before_action :authenticate_user!

  def index
    @units = Unit.all
    @submissions = current_user.submissions
  end


  def mass_edit
    @exercises = Exercise.all
  end

  def update
    if current_user.admin?
      @exercise = Exercise.find(params[:id])
      @exercise.update(link: params[:exercise][:link], name: params[:exercise][:name], points: params[:exercise][:points], exclude: params[:exercise][:exclude])
    end

    if @exercise.save
      redirect_to :mass_edit
    else
      render :update, flash[:errors] = @exercises.errors
    end

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
