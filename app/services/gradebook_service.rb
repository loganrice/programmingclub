require 'csv'

class GradebookService
  attr_reader :users, :units, :active_unit

  def initialize(unit_id=nil)
    @units = ungraded(unit_id)
    set_active_unit(unit_id)
  end

  def set_active_unit(unit_id)
    if unit_id != nil
      @active_unit ||= Unit.find(unit_id)
    else
      @active_unit = nil
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
    if @active_unit
      @submissions ||= Submission.where(exercise: @active_unit.exercises, graded_points: nil ).includes(:user)
    else
      @submissions ||= Submission.includes(:user).all
    end
  end

  def file_paths
    @submissions.select
  end

  def to_csv
    weeks = Submission.group(:created_at).order(created_at: :desc).sum(:graded_points).keys.uniq
    weeks = weeks.map { |week| week.to_date.strftime('%Y-%W') }.uniq
    result = []
    records = Submission.joins(:user).all.group_by { |s| s.user.email }
    records.each do |email, submissions|
      record = {}
      record["student id"] = email.gsub(/[^\d]/, "")
      submissions.each do |sub|
        weeks.each do | week|
          week = week
          if record[week]
            record[week] += sub.graded_points if sub.graded_points
          else
            record[week] = 0 
          end
        end

      end
      result.append(record.values)
    end
    result
    # To a String
    return csv_string = CSV.generate do |csv|
      csv << ["student id"].append(weeks).flatten
      csv << result.flatten
    end

  end

  def print
    submissions.map do |s|
      { user: s.user.email, exercise: s.exercise.name, grade: s.graded_points }
    end
  end
end
