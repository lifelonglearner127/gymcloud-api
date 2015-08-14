# == Schema Information
#
# Table name: folders
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#

class Folder < ActiveRecord::Base

  has_closure_tree

  belongs_to :user

  validates :name, :user_id, presence: true

end
