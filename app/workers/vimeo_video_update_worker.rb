class VimeoVideoUpdateWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(video_id)
    video    = Video.find video_id
    vimeo_id = video.vimeo_id
    client   = Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
    vimeo    = client.video vimeo_id

    if vimeo.status == "available"
      update_video(video, vimeo)
    else
      VimeoVideoUpdateWorker.perform_in(2.minutes, video_id)
    end
  end

  private

  def update_video(video, vimeo_video)
    video.preview_picture_url = vimeo_video.pictures.sizes.second.link
    video.duration  = vimeo_video.duration
    video.vimeo_url = vimeo_video.link
    video.status    = vimeo_video.status

    video.save!
  end

end
