class WorkoutsController < ApplicationController
  def today
    @workout = Workout.find_by("DATE(scheduled_at) = CURDATE()")
    @prev = Workout.find_by("DATE(scheduled_at) = SUBDATE(CURDATE(),1)")
    @next = Workout.find_by("DATE(scheduled_at) = (CURDATE() + INTERVAL 1 DAY)")

    if @workout.nil?
      d = Workout.last.distance
      d += 1 if Workout.where(distance: d).count < 14
      @workout = Workout.create(
        distance: d,
        scheduled_at: Date.today.strftime + ' 20:30:00'
      )
    end

    @worked_out_distance = Workout.where.not(completed_at: nil).pluck(:distance).sum
    @workouts_distance = Workout.all.pluck(:distance).sum
  end

  def show
    @workout = Workout.find(params[:id])
    @prev = @workout.prev
    @next = @workout.next

    @worked_out_distance = Workout.where.not(completed_at: nil).pluck(:distance).sum
    @workouts_distance = Workout.all.pluck(:distance).sum
  end

  def update
    workout = Workout.find(params[:id])
    workout.update(workout_params)
    redirect_to workout
  end

  private

  def workout_params
    params.require(:workout).permit(:completed_at)
  end
end