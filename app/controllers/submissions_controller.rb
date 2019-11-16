class SubmissionsController < ApplicationController

  def index
    @active_unit_id = params[:active_unit_id].present? ? params[:active_unit_id] : Unit.first.try(:id)
    @gradebook = Gradebook.new(@active_unit_id )
    @units = @gradebook.units
    #@users = @gradebook.users
    #@submissions = @gradebook.submissions
    #@print = @gradebook.print
  end

  def grades
    @submissions = GradesService.new(current_user).print
  end

  def show
    @submission = Submission.find(params[:id])
    if @submission && @submission.respond_to?(:file)
      data = @submission.file.download
      send_data data, filename: @submission.file.blob.filename.sanitized, type: @submission.file.blob.content_type, disposition: 'inline'
    else
      redirect_to :back, flash: { error: "Unable to find or open file" }
    end
  end

  def update
    logger.debug params
    @s = Submission.find(params[:id])
    percentage = params[:percentage].to_f / 100
    @s.graded_points = (@s.exercise.points * percentage).ceil
    @s.save
    redirect_to action: :index, active_unit_id: @s.unit.id
  end

  def destroy
    logger.debug "DESTROY  #{params.keys}"
    Submission.find(params[:id]).destroy
    redirect_to root_path
  end
end
