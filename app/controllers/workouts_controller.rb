class WorkoutsController < ApplicationController
  def today
    todays_run_time = Time.zone.now.to_date.strftime + ' 20:30:00'
    beg_of_day = Time.zone.now.beginning_of_day + 7.hours
    end_of_day = Time.zone.now.end_of_day + 7.hours
    @workout = Workout.find_by("scheduled_at >= ? and scheduled_at <= ?", beg_of_day, end_of_day)
    @prev = Workout.find_by("scheduled_at >= ? and scheduled_at <= ?", beg_of_day + 1.day, end_of_day + 1.day)
    @next = Workout.find_by("scheduled_at >= ? and scheduled_at <= ?", beg_of_day + 1.day, end_of_day + 1.day)

    if @workout.nil?
      d = Workout.last.miles_scheduled
      d += 1 if Workout.where(miles_scheduled: d).count == 14
      @workout = Workout.create(
        miles_scheduled: d,
        scheduled_at: todays_run_time
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
    params.require(:workout).permit(:completed_at, :miles_run)
  end
end