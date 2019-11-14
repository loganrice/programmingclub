class Gradebook
  attr_reader :users, :units, :active_unit

  def initialize(unit_id)
    @users = User.all.includes(:submissions)
    @units = Unit.all.includes(:users, :exercises, :submissions)
    set_active_unit(unit_id)
  end

  def set_active_unit(unit_id)
    if unit_id != nil
      @active_unit ||= Unit.find(unit_id)
    end
  end

  def submissions
    @submissions ||= Submission.where(exercise: @active_unit.exercises).includes(:user)
  end

  def print
    submissions.map do |s|
      { user: s.user.email, exercise: s.exercise.name, grade: s.graded_points }
    end
  end
end
