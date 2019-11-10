class ExercisesController < ApplicationController
 # before_action :authenticate_user!

  def index
    @units = Unit.all
  end

end
