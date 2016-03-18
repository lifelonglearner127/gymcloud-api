class AddUniqIndexToProgramWorkouts < ActiveRecord::Migration
  def change
    add_index :program_workouts, [:workout_type, :workout_id], unique: true
  end
end
