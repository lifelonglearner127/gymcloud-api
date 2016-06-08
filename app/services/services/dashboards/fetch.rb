module Services
module Dashboards

class Fetch < BaseService

  def run
    fetch_dashboard
  end

  def input_params
    [:user]
  end

  private

  def fetch_dashboard
    {
      events_scheduled_this_week_count: events(this_week).count,
      events_scheduled_last_week_count: events(last_week).count,
      events_completed_this_week_count: events(this_week).is_completed.count,
      events_scheduled_today: events(today)
    }
  end

  def today
    Date.today.beginning_of_day..Date.today.end_of_day
  end

  def this_week
    Date.today.at_beginning_of_week..Date.today.at_end_of_week
  end

  def last_week
    1.week.ago.at_beginning_of_week..1.week.ago.at_end_of_week
  end

  def events(range)
    if @user.pro?
      ::WorkoutEvent.with_clients(@user).where(begins_at: range)
    else
      @user.workout_events.where(begins_at: range)
    end
  end

end

end
end
