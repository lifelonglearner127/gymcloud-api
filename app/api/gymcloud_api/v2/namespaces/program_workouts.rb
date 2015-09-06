module GymcloudAPI::V2
module Namespaces

class ProgramWorkouts < Base

  desc 'Create Program Workout Template'
  params do
    requires :name, type: String
    requires :program_template_id, type: Integer
    optional :description, type: String
    optional :note, type: String
    optional :video_url, type: String
    optional :folder_id, type: Integer
    optional :is_public, type: Boolean, default: 'false'
    optional :is_visible, type: Boolean, default: 'true'
  end
  post do
    attributes = filtered_params_with(author: current_user)
    program_template_id = attributes.delete('program_template_id')
    program_template = ::ProgramTemplate.find(program_template_id)
    authorize!(:read, program_template)
    folder_id = current_user.folders.root.children
      .where(name: 'Workouts').pluck(:id).first
    workout_template = ::WorkoutTemplate.new(attributes)
    workout_template.folder_id = params[:folder_id] || folder_id
    authorize!(:create, workout_template)
    workout_template.save!
    program_workout = ::ProgramWorkout.create!(
      name: attributes['name'],
      description: attributes['description'],
      video_url: attributes['video_url'],
      workout: workout_template,
      program: program_template
    )
    present(program_workout, with: Entities::ProgramWorkout)
  end

  params do
    requires :id, type: Integer, desc: 'Program Workout ID'
  end
  route_param :id do

    desc 'Read Program Workout Template'
    get do
      program_workout = ::ProgramWorkout.find(params[:id])
      authorize!(:read, program_workout.workout)
      authorize!(:read, program_workout.program)
      present(program_workout, with: Entities::ProgramWorkout)
    end

    desc 'Update Program Workout Template'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :video_url, type: String
    end
    patch do
      program_workout = ::ProgramWorkout.find(params[:id])
      program_workout.assign_attributes(filtered_params)
      authorize!(:update, program_workout.workout)
      authorize!(:update, program_workout.program)
      program_workout.save!
      present(program_workout, with: Entities::ProgramWorkout)
    end

    desc 'Delete Program Workout Template'
    delete do
      program_workout = ::ProgramWorkout.find(params[:id])
      workout_template = program_workout.workout
      authorize!(:destroy, workout_template)
      program_workout.destroy
      present(program_workout, with: Entities::ProgramWorkout)
    end

  end

end

end
end
