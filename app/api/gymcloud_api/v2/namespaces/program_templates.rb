module GymcloudAPI::V2
module Namespaces

class ProgramTemplates < Base

  desc 'Create Program Template'
  post

  route_param :id do

    desc 'Read Program Template'
    get

    desc 'Update Program Template'
    patch

    desc 'Delete Program Template'
    delete

  end

end

end
end
