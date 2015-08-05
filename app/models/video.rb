# == Schema Information
#
# Table name: videos
#
#  id                  :integer          not null, primary key
#  vimeo_id            :integer
#  tmp_file            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  privacy             :integer          default(1)
#  name                :string
#  duration            :integer
#  preview_picture_url :string
#  vimeo_url           :string
#  status              :string
#  embed_url           :string
#  uploaded_at         :datetime
#

class Video < ActiveRecord::Base

  mount_uploader :tmp_file, VideoUploader

  before_destroy :delete_tmp_file_folder

  enum privacy: [:anybody, :nobody, :contacts, :password, :disable]

  def available_for_play?
    self.status == "available"
  end

  def file_uploaded?
    !self.vimeo_id.nil?
  end

  def delete_tmp_file_folder
    self.remove_tmp_file!
    FileUtils.remove_dir("#{Rails.root}/public/uploads/#{self.class.to_s.underscore}/tmp_file/#{self.id}", force: true)
  end

end
