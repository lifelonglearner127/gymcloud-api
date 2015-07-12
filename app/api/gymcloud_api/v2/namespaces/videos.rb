module GymcloudAPI::V2
module Namespaces

class Videos < Base
  helpers do
    def change_privacy video_id, privacy
      @video = Video.find(video_id)
      @video.privacy = privacy
      @video.save!

      client = ::Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
      vimeo_video = client.video @video.vimeo_id
      vimeo_video.edit 'privacy.view' => privacy
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
    optional :privacy, type: String, default: "nobody",
              values: Video.privacies.keys, desc: 'Privacy status'
  end
  post do
    @video = Video.new tmp_file: params[:file], privacy: params[:privacy]
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
      requires :privacy, type: String, default: "nobody",
              values: Video.privacies.keys, desc: 'Privacy status'
    end
    patch do
      change_privacy params[:id], params[:privacy]
      status :no_content
    end


    desc "Publish a video"
    get 'publish' do
      change_privacy params[:id], 'anybody'
      status :no_content
    end


    desc "Unpublish a video"
    get 'unpublish' do
      change_privacy params[:id], 'nobody'
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
