class RegistrationsController < Devise::RegistrationsController

  respond_to :json

  rescue_from ActiveRecord::RecordInvalid do |e|
    rack_response({error: e.record.errors}.to_json, 422)
  end

  def create
    build_resource(sign_up_params)
    resource.skip_confirmation!
    resource.save!
    Services::UserBootstrap::All.!(user: resource)
    entity = {id: resource.id, user_profile: {id: resource.user_profile.id}}

    render json: entity, status: :created
  end

end