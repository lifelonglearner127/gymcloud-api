module GymcloudAPI::V2
module Namespaces

class Videos < Base

  helpers GlobalHelpers

  helpers do
    def update_video(video_id, options = {})
      video = Video.find(video_id)
      options.each do |key, value|
        video.send("#{key}=", value) if video.has_attribute?(key)
      end
      video.save!

      client = ::Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
      vimeo_video = client.video video.vimeo_id
      vimeo_video.edit privacy: {view: video.privacy}, name: video.name

      video
    end
  end

  desc 'Retrieve videos'
  paginate max_per_page: 50
  get do
    present paginate(Video.all), with: Entities::Video
  end

  desc 'Create new video and uploading it to Vimeo'
  params do
    requires :file, type: Rack::Multipart::UploadedFile, desc: 'Video file'
    requires :name, type: String, desc: 'Video name'
    optional :privacy, type: String, default: 'nobody',
              values: Video.privacies.keys, desc: 'Privacy status'
  end
  post do
    video = Video.new(
      tmp_file: params[:file],
      privacy: params[:privacy],
      name: params[:name]
    )
    video.save!
    VimeoUploaderService.new.upload(video)
    VimeoVideoUpdateWorker.perform_in(2.minutes, video.id)

    present video, with: Entities::Video
  end

  params do
    requires :id, type: Integer, desc: 'Video ID'
  end
  route_param :id do

    desc 'Retrieve a video'
    get do
      Video.find params[:id]
    end

    desc 'Update a video'
    params do
      optional :privacy, type: String, default: 'nobody',
              values: Video.privacies.keys, desc: 'Privacy status'
      optional :name, type: String, desc: 'Video name'
      at_least_one_of :privacy, :name
    end
    patch do
      video = update_video params[:id], params
      present video, with: Entities::Video
    end

    desc 'Publish a video'
    get 'publish' do
      video = update_video params[:id], privacy: 'anybody'
      present video, with: Entities::Video
    end

    desc 'Unpublish a video'
    get 'unpublish' do
      video = update_video params[:id], privacy: 'nobody'
      present video, with: Entities::Video
    end

    desc 'Delete a video'
    delete do
      video    = Video.find params[:id]
      vimeo_id = video.vimeo_id
      video.destroy!

      VimeoVideoDeleteWorker.perform_async(vimeo_id) if vimeo_id

      present video, with: Entities::Video
    end

  end

  namespace '/search' do

    desc 'Search vimeo video'
    params do
      requires :q, type: String, desc: 'Query for search'
      use :pagination
    end
    get '/vimeo' do
      vimeo_search = VimeoVideoSearchService.new(params)
      videos = vimeo_search.search

      present videos, with: Entities::VimeoVideo
    end

    desc 'Search youtube video'
    params do
      requires :q, type: String, desc: 'Query for search'
      use :pagination
    end
    get '/youtube' do
      yt_search = YoutubeVideoSearchService.new(params)
      videos = yt_search.search

      present videos, with: Entities::YoutubeVideo
    end

  end

end

end
end
