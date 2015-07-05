module GymcloudAPI::V2

module Helpers

  def filtered_params
    declared params, \
      include_missing: false
  end

end

end
