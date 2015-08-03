class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  acts_as_readable on: :created_at

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  default_scope -> { order('created_at ASC') }

  validates :comment, :user_id, :commentable_id, :commentable_type, presence: true

end
