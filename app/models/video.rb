class Video < ActiveRecord::Base
  mount_uploader :tmp_file, VideoUploader

  before_destroy :delete_tmp_file_folder

  enum privacy: [:anybody, :nobody, :contacts, :password, :disable]

  def vimeo_url
    "https://vimeo.com/#{self.vimeo_id}" unless self.vimeo_id.nil?
  end

  def file_uploaded?
    !self.vimeo_id.nil?
  end

  def delete_tmp_file_folder
    self.remove_tmp_file!
    FileUtils.remove_dir("#{Rails.root}/public/uploads/#{self.class.to_s.underscore}/tmp_file/#{self.id}", force: true)
  end

  def as_json(options = {})
    super( {methods: :vimeo_url}.merge(options) )
  end
end
