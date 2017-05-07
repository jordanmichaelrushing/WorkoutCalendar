class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer :distance
      t.datetime :scheduled_at
      t.datetime :completed_at

      t.timestamps null: false
    end
  end
end
