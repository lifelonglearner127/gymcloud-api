module GymcloudAPI::V2
module Entities

class User < Grape::Entity

  expose :id
  expose :pro?, as: :is_pro
  expose :email, if: {email: true}
  expose :unconfirmed_email,
    if: lambda do |user, options|
      options[:email] && user.unconfirmed_email?
    end
  expose :user_profile, using: Entities::UserProfile

end

end
end
