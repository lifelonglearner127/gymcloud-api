module Services
module ProgramWorkout

class Create < BaseService

  input_params :program_template_id, :workout_template_id
  run :create_program_workout

  def build_program_workout
    ::ProgramWorkout.new(prepare_attributes)
  end

  private

  def create_program_workout
    ::ProgramWorkout.create!(prepare_attributes)
  end

  def prepare_attributes
    program_template = ::ProgramTemplate.find(@program_template_id)
    workout_template = ::WorkoutTemplate.find(@workout_template_id)
    to_include = %w(name description note video_url)
    workout_template.attributes.slice(*to_include).merge(
      program: program_template,
      workout: workout_template
    )
  end

end

end
end