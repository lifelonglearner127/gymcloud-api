class AddUniqIndexToProgramWorkouts < ActiveRecord::Migration
  def change
    remove_index :program_workouts, [:workout_type, :workout_id]
    add_index :program_workouts, [:workout_type, :workout_id], unique: true
  end
end
