module GymcloudAPI::V2
module Namespaces

class ProgramWorkouts < Base

  desc 'Create Program Workout Template'
  params do
    requires :program_template_id, type: Integer
    requires :workout_template_id, type: Integer
    optional :position, type: Integer
    optional :week_id, type: Integer
  end
  post do
    service = Services::ProgramWorkout::Create.new(
      program_template_id: params[:program_template_id],
      workout_template_id: params[:workout_template_id]
    )
    authorize!(:create, service.build_program_workout)
    program_workout = service.process.result
    present(program_workout, with: Entities::ProgramWorkout)
  end

  params do
    requires :id, type: Integer, desc: 'Program Workout ID'
  end
  route_param :id do

    desc 'Read Program Workout Template'
    get do
      program_workout = ::ProgramWorkout.find(params[:id])
      authorize!(:read, program_workout)
      present(program_workout, with: Entities::ProgramWorkout)
    end

    desc 'Update Program Workout Template'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :video_url, type: String
      optional :position, type: Integer
      optional :week_id, type: Integer
    end
    patch do
      program_workout = ::ProgramWorkout.find(params[:id])
      program_workout.assign_attributes(filtered_params)
      authorize!(:update, program_workout)
      program_workout.save!
      present(program_workout, with: Entities::ProgramWorkout)
    end

    desc 'Delete Program Workout Template'
    delete do
      program_workout = ::ProgramWorkout.find(params[:id])
      authorize!(:destroy, program_workout)
      program_workout = Services::ProgramWorkout::Destroy.!(
        program_workout: program_workout
      )
      present(program_workout, with: Entities::ProgramWorkout)
    end

  end

end

end
end
