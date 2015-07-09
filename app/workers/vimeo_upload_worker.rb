class VimeoUploadWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(video_id)
    video = Video.find(video_id)

    # uploader = Vimeo::Advanced::Upload.new("consumer_key", "consumer_secret", token: user.token, secret: user.secret)
    # upload.get_quota
    # vimeo_id = uploader.upload(video.tmp_file.path)
    # video.vimeo_id = vimeo_id
    # video.delete_tmp_file_folder
    # video.save!
  end
end
