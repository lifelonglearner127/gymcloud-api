class PersonalProperty < ActiveRecord::Base

  belongs_to :global_property
  belongs_to :person, class_name: User

  validates :global_property_id, :person_id, presence: true

end
