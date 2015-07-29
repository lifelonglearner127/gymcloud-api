class Exercise < ActiveRecord::Base

  belongs_to :author, class_name: User

  validates :name, :author_id, presence: true

  validates :is_public, inclusion: { in: [true, false] }

end
