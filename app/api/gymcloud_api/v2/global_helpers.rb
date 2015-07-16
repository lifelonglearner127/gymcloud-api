module GymcloudAPI
module V2

module GlobalHelpers
  extend Grape::API::Helpers

  def filtered_params
    declared params, \
      include_missing: false
  end

  params :pagination do
    optional :page,     type: Integer, desc: 'Page  number'
    optional :per_page, type: Integer, desc: 'Items per page'
  end
end

end
end
