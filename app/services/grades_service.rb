class GradesService
  attr_reader :dates, :submissions
  def initialize(user)
    @submission = set_submissions(user.id)
  end

  def set_submissions(user_id)
    sql = <<-DOC
      Select * 
      FROM submissions sub
      LEFT JOIN exercises ex
      on ex.id = sub.exercise_id
      where ex.exclude IS NOT true OR ex.exclude IS NULL AND sub.user_id = #{user_id}
    DOC
    @submissions = Submission.joins(:user).where("user_id = #{user_id}").joins(:exercise).where("exercises.exclude IS NULL OR exercises.exclude = false")
    #@submission = Submission.find_by_sql(sql)
    @submissions = [] if @submissions.nil?
  end

  def print
    submissions.group_by(&:week)
    #submission.map {|x| x.week }
  end
end
