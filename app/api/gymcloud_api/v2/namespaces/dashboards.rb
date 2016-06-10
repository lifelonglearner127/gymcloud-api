module GymcloudAPI::V2
module Namespaces

class Dashboards < Base

namespace :dashboards do

  resource :pro do
    desc 'Fetch Pro dashboard'
    get do
      dashboard = Services::Dashboards::Fetch.!(user: current_user)
      present(
        dashboard,
        with: Entities::Dashboard,
        is_pro: true,
        dashboard: true
      )
    end
  end

  resource :client do
    desc 'Fetch Client dashboard'
    get do
      dashboard = Services::Dashboards::Fetch.!(user: current_user)
      present(dashboard, with: Entities::Dashboard, dashboard: true)
    end
  end

end

end

end
end
