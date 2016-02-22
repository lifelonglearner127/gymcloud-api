module GymcloudAPI::V2
module Namespaces

class ProgramPresets < Base

namespace :program_presets do

  desc 'Get Preset List'
  get do
    presets = ::ProgramPreset.order(:id).all
    present(presets, with: Entities::ProgramPreset)
  end

end

end

end
end
