module GymcloudAPI::V2
module Namespaces

class Videos < Base

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
      @video = Video.find(params[:id])
      @video.published = params[:published]
      @video.save!

      status :no_content
    end


    desc 'Delete a video'
    delete do
      Video.find(params[:id]).delete

      status :no_content
    end
  end

end

end
end
