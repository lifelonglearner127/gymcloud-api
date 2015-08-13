module GymcloudAPI::V2
module Namespaces

class PersonalPrograms < Base

  desc 'Create Personal Program'
  params do
    requires :program_template_id, type: Integer, desc: 'Program Template ID'
    requires :person_id, type: Integer, desc: 'Assigned Person ID'
  end
  post do
    template = ::ProgramTemplate.find(params[:program_template_id])
    user = ::User.find(params[:person_id])
    service = Services::PersonalAssignment::Program.new(
      template: template,
      user: user
    )
    authorize!(:create, service.build_personal)
    program = service.process.result
    present(program, with: Entities::PersonalProgram)
  end

  params do
    requires :id, type: Integer, desc: 'Personal Program ID'
  end
  route_param :id do

    desc 'Read Personal Program'
    get do
      program = ::PersonalProgram.find(params[:id])
      present program, with: Entities::PersonalProgram
    end

    desc 'Update Personal Program'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :status, type: String, desc: 'Activity status',
                values: ::PersonalProgram.statuses.keys
    end
    patch do
      program = ::PersonalProgram.find params[:id]
      program.update_attributes! filtered_params
      present program, with: Entities::PersonalProgram
    end

    desc 'Delete Personal Program'
    delete do
      program = ::PersonalProgram.destroy(params[:id])
      present program, with: Entities::PersonalProgram
    end

  end

end

end
end
