module Services
module ProgramWorkout

class Create < BaseService

  def run
    create_program_workout
  end

  def input_params
    [:attrs]
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
    workout_template = ::WorkoutTemplate.find(@attrs['workout_template_id'])
    new_workout_template = Services::TemplateDuplicating::Workout.!(
      workout: workout_template,
      user: workout_template.user,
      is_visible: false
    )
    to_include = %w(name description note video_url)
    workout_template.attributes.slice(*to_include)
      .merge(
        program: program_template,
        workout: new_workout_template,
        position: @attrs['position'],
        week_id: @attrs['week_id']
      )
  end

end

end
end
