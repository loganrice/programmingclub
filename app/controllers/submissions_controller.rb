class SubmissionsController < ApplicationController
  def destroy
    logger.debug "DESTROY  #{params.keys}"
    Submission.find(params[:id]).destroy
    redirect_to root_path
  end
end
