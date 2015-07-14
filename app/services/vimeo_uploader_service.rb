class VimeoUploaderService
  def initialize
    @client    = Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
    @client_me = @client.me
  end

  def upload(video)
    @video = video

    check_quota
    ticket      = get_ticket
    vimeo_id    = send_video_data ticket
    vimeo_video = @client.video vimeo_id

    update_vimeo_video vimeo_video
    update_video vimeo_id, vimeo_video

    return @video
  end

  private

  def check_quota
    free_space = @client_me.upload_quota.space.free
    video_size = @video.tmp_file.file.size
    raise Vimeo::UploadeQuotaLimit if free_space < video_size
  end

  def get_ticket
    Hashie::Mash.new @client_me.new_video(type: 'POST', redirect_url: 'http://any_domain.com/vimeo')
  end

  def send_video_data ticket
    @client.upload :post, @video.tmp_file.file, ticket
  end

  def update_vimeo_video vimeo_video
    vimeo_video.edit privacy: {view: @video.privacy}, name: @video.name
  end

  def update_video vimeo_id, vimeo_video
    @video.vimeo_id    = vimeo_id
    @video.vimeo_url   = vimeo_video.link
    @video.status      = vimeo_video.status
    @video.uploaded_at = DateTime.now
    @video.embed_url   = get_embed_url(vimeo_video.embed.html)
    @video.delete_tmp_file_folder
    @video.save!
  end

  def get_embed_url str
    url = URI::extract(str).first
    url.sub("?#{URI(url).query}", '')
  end

end
