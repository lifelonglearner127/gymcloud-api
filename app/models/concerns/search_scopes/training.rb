module SearchScopes
module Training

  MASTER_EMAILS = ['support@gymcloud.com'].freeze

  extend ActiveSupport::Concern

  included do

    scope :owned_by, ->(id) { where(user_id: id) }

    scope :not_owned_by, ->(id) { where.not(user_id: id) }

    scope :owned_by_master, (lambda do
      joins(:user)
        .where(users: {email: MASTER_EMAILS})
    end)

    scope :public_for, (lambda do |id|
      not_owned_by(id)
        .owned_by_master
        .where(is_public: true)
    end)

    scope :global_for, (lambda do |id|
      joins(:user)
        .where do
          (users.email >> my { MASTER_EMAIL }) & (is_public == true) |
          (user_id == my { id })
        end
    end)

    scope :search_by_criteria, (lambda do |criteria|
      where { name =~ my { criteria } }
    end)

  end

end
end
