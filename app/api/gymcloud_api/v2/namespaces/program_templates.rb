module GymcloudAPI::V2
module Namespaces

class ProgramTemplates < Base

  desc 'Create Program Template'
  params do
    requires :name, type: String
    optional :description, type: String
    optional :note, type: String
    optional :is_public, type: Boolean, default: 'false'
  end
  post do
    attributes = filtered_params_with(author: current_user)
    template = ::ProgramTemplate.create!(attributes)
    present template, with: Entities::ProgramTemplate
  end

  params do
    requires :id, type: Integer, desc: 'ProgramTemplate ID'
  end
  route_param :id do

    desc 'Read Program Template'
    get do
      template = ::ProgramTemplate.find(params[:id])
      present template, with: Entities::ProgramTemplate
    end

    desc 'Update Program Template'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :is_public, type: Boolean
    end
    patch do
      program_template = ::ProgramTemplate.find params[:id]
      program_template.update_attributes! filtered_params
      present program_template, with: Entities::ProgramTemplate
    end

    desc 'Delete Program Template'
    delete do
      template = ::ProgramTemplate.destroy(params[:id])
      present template, with: Entities::ProgramTemplate
    end

  end

end

end
end
