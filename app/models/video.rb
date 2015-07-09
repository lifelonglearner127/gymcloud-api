class Video < ActiveRecord::Base
  mount_uploader :tmp_file, VideoUploader

  before_destroy :delete_tmp_file_folder

  def delete_tmp_file_folder
    self.remove_tmp_file!
    FileUtils.remove_dir("#{Rails.root}/public/uploads/#{self.class.to_s.underscore}/tmp_file/#{self.id}", force: true)
  end
end
