module Services
module Dashboards

class Pro < Client

  private

  def events
    ::WorkoutEvent.with_clients(@user)
  end

end

end
end
