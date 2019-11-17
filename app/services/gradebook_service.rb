class GradebookService
  attr_reader :users, :units, :active_unit

  def initialize(unit_id)
    @units = ungraded(unit_id)
    set_active_unit(unit_id)
  end

  def set_active_unit(unit_id)
    if unit_id != nil
      @active_unit ||= Unit.find(unit_id)
    end
  end

  def ungraded(unit_id)
    sql = <<-DOC
      Select sub.id, units.name as unit, u.email as email, ex.name, ex.points, sub.graded_points 
      FROM submissions sub
      LEFT JOIN users u
      on u.id = sub.user_id
      LEFT JOIN exercises ex
      on ex.id = sub.exercise_id
      LEFT JOIN units
      on units.id = ex.unit_id
      where graded_points IS NULL
      ORDER BY ex.name
    DOC

    return Submission.find_by_sql(sql).group_by { |u| u["unit"] }
  end

  def submissions
    @submissions ||= Submission.where(exercise: @active_unit.exercises, graded_points: nil ).includes(:user)
  end

  def file_paths
    @submissions.select
  end

  def print
    submissions.map do |s|
      { user: s.user.email, exercise: s.exercise.name, grade: s.graded_points }
    end
  end
end
