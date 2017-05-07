class Workout < ActiveRecord::Base

  def completed?
    !completed_at.nil?
  end
end
