module Services
module TemplateDuplicating

class Program < BaseService

  def run
    duplicate
  end

  def input_params
    [:program, :user, :folder_id]
  end

  def defaults
    {folder_id: nil}
  end

  def build
    ::ProgramTemplate.new(prepare_attributes)
  end

  private

  def duplicate
    @new_program = ::ProgramTemplate.create!(prepare_attributes)

    @program.program_weeks.each do |pw|
      duplicate_program_week(pw)
    end
    @program.program_workouts.where(week_id: nil).each do |pw|
      duplicate_program_workout(pw, nil)
    end

    @new_program
  end

  def prepare_attributes
    to_include = %w(name description note video_url)
    @exercise.attributes.slice(*to_include).merge(
      is_public: false,
      folder_id: prepare_folder,
      author: @user
    )
  end

  def prepare_folder
    @folder_id ||= ::Folder.find_by(name: 'Programs', user: @user).id
  end

  def duplicate_program_week(program_week)
    new_program_week = program_week.dup.assign_attributes(
      program: @new_program,
      created_at: nil,
      updated_at: nil
    )
    new_program_week.save!
    program_week.program_workouts.each do |program_workout|
      duplicate_program_workout(program_workout, new_program_week)
    end
    new_program_week
  end

  def duplicate_program_workout(program_workout, new_program_week)
    new_program_workout = program_workout.dup.assign_attributes(
      week: new_program_week,
      program: @new_program,
      workout: duplicate_workout(program_workout.workout),
      created_at: nil,
      updated_at: nil
    )
    new_program_workout.save!
  end

  def duplicate_workout(workout)
    Services::TemplateDuplicating::Workout.!(
      workout: workout,
      user: @user,
      is_visible: false
    )
  end

end

end
end
