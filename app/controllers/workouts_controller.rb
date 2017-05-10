class WorkoutsController < ApplicationController
  def today
    @workout = Workout.find_by("DATE(scheduled_at) = CURDATE()")
    @prev = Workout.find_by("DATE(scheduled_at) = SUBDATE(CURDATE(),1)")
    @next = Workout.find_by("DATE(scheduled_at) = (CURDATE() + INTERVAL 1 DAY)")

    if @workout.nil?
      d = Workout.last.miles_scheduled
      d += 1 if Workout.where(miles_scheduled: d).count < 14
      @workout = Workout.create(
        miles_scheduled: d,
        scheduled_at: Date.today.strftime + ' 20:30:00'
      )
    end

    @worked_out_distance = Workout.where.not(completed_at: nil).pluck(:miles_run).sum
    @workouts_distance = Workout.all.pluck(:miles_scheduled).sum
  end

  def show
    @workout = Workout.find(params[:id])
    @prev = @workout.prev
    @next = @workout.next

    @worked_out_distance = Workout.where.not(completed_at: nil).pluck(:miles_run).sum
    @workouts_distance = Workout.all.pluck(:miles_scheduled).sum
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