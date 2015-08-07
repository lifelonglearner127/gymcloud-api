module GymcloudAPI::V2
module Namespaces

class PersonalProperties < Base

  params do
    requires :id, type: Integer, desc: 'Personal Property ID'
  end
  route_param :id do

    desc 'Read Personal Property'
    get do
      present ::PersonalProperty.find(params[:id]), with: Entities::PersonalProperty
    end

    desc 'Update Personal Property'
    params do
      optional :position, type: Integer
      optional :is_visible, type: Boolean, default: 'true'
    end
    patch do
      property = ::PersonalProperty.find params[:id]
      property.update_attributes! filtered_params.to_h
      present property, with: Entities::PersonalProperty
    end

  end

end

end
end
