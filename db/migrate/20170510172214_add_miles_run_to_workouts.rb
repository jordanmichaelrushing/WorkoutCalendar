class AddMilesRunToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :miles_run, :decimal, default: 0.0, precision: 8, scale: 2
    rename_column :workouts, :distance, :miles_scheduled
    change_column :workouts, :miles_scheduled, :decimal, default: 0.0, precision: 8, scale: 2
  end
end
