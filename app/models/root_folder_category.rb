# == Schema Information
#
# Table name: root_folder_categories
#
#  id         :integer          not null, primary key
#  klass      :string
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class RootFolderCategory < ActiveRecord::Base
end
