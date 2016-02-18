module GymcloudAPI::V2
module Namespaces

class Presets < Base

namespace :Presets do

  desc 'Get Preset List'
  get do
    presets = ::Preset.order(:id).all
    present(presets, with: Entities::Preset)
  end

end

end

end
end
