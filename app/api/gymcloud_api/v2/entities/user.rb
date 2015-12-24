module GymcloudAPI::V2
module Entities

class User < Grape::Entity

  expose :id,
    documentation: {
      desc: 'id',
      type: 'integer',
      required: true
    }

  expose :email,
    if: (lambda do |user, options|
      options[:email] && user.live
    end),
    documentation: {
      desc: 'email',
      type: 'string',
      required: true
    }

  expose :live,
    documentation: {
      desc: 'real live user',
      type: 'boolean'
    } \
  do |user|
    user.live
  end

  expose :unconfirmed_email,
    if: (lambda do |user, options|
      options[:email] && user.unconfirmed_email?
    end),
    documentation: {
      desc: 'unconfirmed_email',
      type: 'string'
    }

  expose :pro?,
    as: :is_pro,
    documentation: {
      desc: 'professional flag',
      type: 'boolean'
    }

  expose :user_profile,
    using: Entities::UserProfile,
    documentation: {
      desc: 'user profile',
      type: Entities::UserProfile,
      param_type: 'body'
    }

end

end
end
