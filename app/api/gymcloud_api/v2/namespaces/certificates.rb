module GymcloudAPI::V2
module Namespaces

class Certificates < Base

namespace :certificates do

  desc 'Upload Certificate'
  params do
    requires :file, type: Rack::Multipart::UploadedFile
  end
  post do
    certificate = current_user.certificate || current_user.build_certificate
    authorize!(:upload, certificate)
    certificate.file = ActionDispatch::Http::UploadedFile.new(params[:file])
    certificate.save!
    present(certificate)
  end

end

end

end
end
