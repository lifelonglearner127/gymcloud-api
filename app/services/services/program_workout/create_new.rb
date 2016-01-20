module Services
module ProgramWorkout

class CreateNew < BaseService

  def run
    create_program_workout
  end

  def input_params
    [:attrs, :user]
  end

  def build_program_workout
    ::ProgramWorkout.new(prepare_attributes)
  end

  private

  def create_program_workout
    ::ProgramWorkout.create!(prepare_attributes)
  end

  def prepare_attributes
    program_template = ::ProgramTemplate.find(@attrs['program_template_id'])

    {
      program: program_template,
      workout: workout_template,
      position: @attrs['position'],
      week_id: @attrs['week_id']
    }
  end

  def workout_template
    folder_id = @user.folders.root.children
      .where(name: 'Workouts').pluck(:id).first

    ::WorkoutTemplate.create!(
      name: "Workout #{@attrs['position']}".squish,
      folder_id: folder_id,
      is_visible: false,
      is_public: false,
      author: @user,
      user: @user
    )
  end

end

end
end
