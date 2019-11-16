class GradesService
  attr_reader :dates
  def initialize(user)
    @submission = Submission.all.where(user: user)
  end

  def print
    @submission.group_by(&:week)
  end
end
