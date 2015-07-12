class VimeoUploadWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(video_id)
    @video     = Video.find video_id
    @client    = Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
    @client_me = @client.me

    check_quota
    @ticket = get_ticket
    vimeo_id = send_video_data
    vimeo_video = @client.video vimeo_id

    change_video_privacy vimeo_video

    @video.vimeo_id = vimeo_id
    @video.embed    = vimeo_video.embed.html
    @video.delete_tmp_file_folder
    @video.save!
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

  def send_video_data
    @client.upload :post, @video.tmp_file.file, @ticket
  end

  def change_video_privacy vimeo_video
    vimeo_video.edit 'privacy.view' => @video.privacy
  end
end
