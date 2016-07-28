module GymcloudAPI::V2
module Namespaces

class Pros < Base

namespace :pros do

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
    Services::Pros::Invite.!(
      current_user: current_user,
      user: pro,
      email: params[:email]&.downcase&.squish
    )
    present(pro, with: Entities::User)
  end

end

end

end
end
