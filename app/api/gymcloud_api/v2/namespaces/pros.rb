module GymcloudAPI::V2
module Namespaces

class Pros < Base

namespace :pros do

  helpers do
    def invite(pro)
      Services::Pros::Invite.!(
        current_user: current_user,
        user: pro,
        email: params[:email]&.downcase&.squish
      )
    end
  end

  desc 'Create Pro'
  params do
    requires :first_name, type: String
    requires :last_name, type: String
    optional :email, type: String
  end
  post do
    pro = ::User.where(email: params[:email]).take

    unless pro
      service = Services::Pros::Create.new(
        attrs: filtered_params,
        current_user: current_user
      )
      pro = service.build_pro
      authorize!(:create, pro)
      service.process
      pro = service.result
    end

    authorize!(:invite, pro)
    invite(pro)
    present(pro, with: Entities::User)
  end

  desc 'Provide Pro'
  post '/request' do
    request = ::RequestPro.find_or_initialize_by(
      client: current_user,
      pro_provided: false
    )
    authorize!(:create, request)
    request.save!
    ::HtmlMailer.delay.provide_pro(current_user.id)
    present(request)
  end

end

end

end
end
