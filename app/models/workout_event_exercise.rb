# == Schema Information
#
# Table name: workout_event_exercises
#
#  id                  :integer          not null, primary key
#  workout_event_id    :integer
#  workout_exercise_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class WorkoutEventExercise < ActiveRecord::Base

  belongs_to :workout_event
  belongs_to :workout_exercise

end
