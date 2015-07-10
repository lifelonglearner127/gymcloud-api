module GymcloudAPI::V2
module Namespaces

class Videos < Base
  helpers do
    def change_publish video_id, state
      vimeo_privacy = {
        'true'  => 'disable',
        'false' => 'nobody'
      }[state.to_s]

      @video = Video.find(video_id)
      @video.published = state
      @video.save!

      client = ::Vimeo::Client.new access_token: '4aabe27d55ff434dc6ba7ec97c930e9b'
      vimeo_video = client.video @video.vimeo_id
      vimeo_video.edit 'privacy.view' => vimeo_privacy
    end
  end


  desc "Retrieve videos"
  paginate max_per_page: 50
  get do
    paginate Video.all
  end


  desc "Create new video and uploading it to Vimeo"
  params do
    requires :file, type: Rack::Multipart::UploadedFile, desc: "Video file"
  end
  post do
    @video = Video.new tmp_file: params[:file]
    @video.save!
    VimeoUploadWorker.perform_async(@video.id)

    status :accepted
  end



  params do
    requires :id, type: Integer, desc: "Video ID"
  end
  route_param :id do
    desc "Retrieve a video"
    get do
      Video.find params[:id]
    end


    desc 'Change a video published status'
    params do
      requires :published, type: Boolean, desc: 'Published status'
    end
    patch do
      change_publish params[:id], params[:published]
      status :no_content
    end


    desc "Publih a video"
    get 'publish' do
      change_publish params[:id], true
      status :no_content
    end


    desc "Unpublih a video"
    get 'unpublish' do
      change_publish params[:id], false
      status :no_content
    end


    desc 'Delete a video'
    delete do
      Video.destroy params[:id]
      status :no_content
    end
  end


end

end
end
