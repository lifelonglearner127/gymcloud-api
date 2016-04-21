class HtmlMailer < ApplicationMailer

  layout 'zurb'

  def welcome_new_user(user_id)
    @user = ::User.find(user_id)
    mail(to: @user.email, subject: "We're happy you're here!")
  end

  def program_assigned(user_id, program_id)
    email = ::User.find(user_id).email
    @program = ::PersonalProgram.find(program_id)
    mail(to: email, subject: 'GymCloud')
  end

  def workout_assigned(user_id, workout_id)
    email = ::User.find(user_id).email
    @workout = ::PersonalWorkout.find(workout_id)
    mail(to: email, subject: 'GymCloud')
  end

  def event_scheduled(user_id, event_id)
    email = ::User.find(user_id).email
    @event = ::WorkoutEvent.find(event_id)
    mail(to: email, subject: 'GymCloud')
  end

  def event_changed(user_id, event_id)
    email = ::User.find(user_id).email
    # NOTE: We cannot change event time for now
    @event = ::WorkoutEvent.find(event_id)
    mail(to: email, subject: 'GymCloud')
  end

  def results_added(user_id, event_id)
    email = ::User.find(user_id).email
    @event = ::WorkoutEvent.find(event_id)
    mail(to: email, subject: 'GymCloud')
  end

  def comment_added(user_id, comment_id)
    email = ::User.find(user_id).email
    @comment = ::Comment.find(comment_id)
    mail(to: email, subject: 'GymCloud')
  end

  def trial_expiration(user_id)
    @user = ::User.find(user_id)
    @days_left = (@user.trial_expiration.to_date - Date.today).to_i
    mail(to: @user.email, subject: 'GymCloud')
  end

end
