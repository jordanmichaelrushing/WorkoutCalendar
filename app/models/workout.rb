class Workout < ActiveRecord::Base

  def completed?
    !completed_at.nil?
  end

  def next
    Workout.find_by(scheduled_at: self.scheduled_at + 1.day)
  end

  def prev
    Workout.find_by(scheduled_at: self.scheduled_at - 1.day)
  end
end
