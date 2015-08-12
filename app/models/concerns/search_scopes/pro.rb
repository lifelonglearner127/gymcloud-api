module SearchScopes
module Pro

  extend ActiveSupport::Concern

  included do
    scope :owned_by, ->(id) { find(id).clients }
    scope :public_for, ->(id) { nil }
    scope :global_for, ->(id) { owned_by(id) }
    scope :search_by_criteria, ->(criteria) {
      joins{user_profile}.where{
        (user_profile.first_name=~my{criteria}) |
        (user_profile.last_name=~my{criteria})
      }
    }
  end

end
end