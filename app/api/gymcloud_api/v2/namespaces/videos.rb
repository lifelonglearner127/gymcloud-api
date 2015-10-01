module GymcloudAPI::V2
module Namespaces

class Videos < Base

namespace :videos do

  helpers GlobalHelpers

  desc 'Retrieve videos'
  paginate max_per_page: 50
  get do
    present paginate(Video.all), with: Entities::Video
  end

  desc 'Create new video and uploading it to Vimeo'
  params do
    requires :file, type: Rack::Multipart::UploadedFile, desc: 'Video file'
    requires :name, type: String, desc: 'Video name'
  end
  post do
    video = Video.new(tmp_file: params[:file], name: params[:name])
    # NOTE: this is not async b/c of heroku limits
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
      video = Video.find(params[:id])
      present(video, with: Entities::Video)
    end

    desc 'Update a video'
    params do
      requires :name, type: String, desc: 'Video name'
    end
    patch do
      video = Video.find(params[:id])
      video.name = params[:name]
      video.save!

      client = ::Vimeo::Client.new(access_token: ENV['VIMEO_TOKEN'])
      vimeo_video = client.video(video.vimeo_id)
      vimeo_video.edit(name: video.name)

      present(video, with: Entities::Video)
    end

    desc 'Delete a video'
    delete do
      video = Video.find(params[:id])
      vimeo_id = video.vimeo_id
      video.destroy!

      VimeoVideoDeleteWorker.perform_async(vimeo_id) if vimeo_id

      present(video, with: Entities::Video)
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

      present(videos, with: Entities::VimeoVideo)
    end

    desc 'Search youtube video'
    params do
      requires :q, type: String, desc: 'Query for search'
      use :pagination
    end
    get '/youtube' do
      yt_search = YoutubeVideoSearchService.new(params)
      videos = yt_search.search

      present(videos, with: Entities::YoutubeVideo)
    end

  end

end

end

end
end