module GymcloudAPI::V2
module Namespaces

class AccountTypes < Base

namespace :Presets do

  desc 'Get Preset List'
  get do
    presets = ::AccountType.order(:id).all
    present(presets, with: Entities::Preset)
  end

end

end

end
end
