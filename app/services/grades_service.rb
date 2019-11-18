class GradesService
  attr_reader :dates
  def initialize(user)
    @submission = submissions(user.id)
  end

  def submissions(user_id)
    sql = <<-DOC
      Select * 
      FROM submissions sub
      LEFT JOIN exercises ex
      on ex.id = sub.exercise_id
      where ex.exclude IS NOT true AND sub.user_id = #{user_id}
    DOC

    @submission ||= Submission.find_by_sql(sql)
  end

  def print
    @submission.group_by(&:week)
  end
end
