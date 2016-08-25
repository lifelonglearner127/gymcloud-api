module GymcloudAPI::V2
module Namespaces

class Certificates < Base

namespace :certificates do

  desc 'Upload Certificate'
  params do
    requires :files, type: [Rack::Multipart::UploadedFile]
  end
  post do
    certificate = current_user.certificates.build
    authorize!(:upload, certificate)
    certificate.file = ActionDispatch::Http::UploadedFile.new(params[:files][0])
    certificate.status = :unverified
    certificate.save!
    present(certificate)
  end

end

end

end
end
