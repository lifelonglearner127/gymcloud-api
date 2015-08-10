require 'active_support/concern'
module SearchScopes
  module Training extend ActiveSupport::Concern
    included do
      scope :owned_by, ->(id) { where(author_id: id) }
      scope :not_owned_by, ->(id) { where.not(author_id: id) }
      scope :public_for, ->(id) { not_owned_by(id).where(is_public: true) }
      scope :global_for, ->(id) {
        where{ (author_id == my{id}) | (is_public == true) }
      }
      scope :search_by_criteria, ->(criteria) { where{ name=~my{criteria} } }
    end
  end

  module Pro extend ActiveSupport::Concern
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

  module ClientGroup extend ActiveSupport::Concern
    included do
      scope :owned_by, ->(id) { where(pro_id: id) }
      scope :public_for, ->(id) { nil }
      scope :global_for, ->(id) { owned_by(id) }
      scope :search_by_criteria, ->(criteria) { where{ name=~my{criteria} } }
    end
  end


end