class ExercisesController < ApplicationController
  def index
    @units = Unit.all
  end

end
