module GymcloudAPI::V2
module Namespaces

class PersonalPrograms < Base

  desc 'Create Personal Program'
  post

  params do
    requires :id, type: Integer, desc: 'Personal Program ID'
  end
  route_param :id do

    desc 'Read Personal Program'
    get do
      present ::PersonalProgram.find(params[:id]), with: Entities::PersonalProgram
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
      present ::PersonalProgram.destroy(params[:id]), with: Entities::PersonalProgram
    end

  end

end

end
end
