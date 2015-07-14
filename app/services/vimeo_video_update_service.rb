class VimeoVideoUpdateService
  def initialize
    @client = Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
  end

  def update video
    vimeo = @client.video video.vimeo_id

    if vimeo.status == "available"
      update_video(video, vimeo)
    else
      false
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
