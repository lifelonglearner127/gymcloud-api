module MailerHelper

  def webapp_domain
    ENV['DOMAIN_WEBAPP']
  end

  def inivitation_url(token, user)
    params = {
      invitation_token: token,
      first_name: user.user_profile.first_name,
      last_name: user.user_profile.last_name,
      email: user.email,
      client_id: user.id,
      user_profile_id: user.user_profile.id
    }.to_param
    "http://#{webapp_domain}/#signup?#{params}"
  end

  def personal_program_url(id)
    "http://#{webapp_domain}/#personal_programs/#{id}"
  end

  def personal_workout_url(id)
    "http://#{webapp_domain}/#personal_workouts/#{id}"
  end

  def confirmation_on_frontend(token)
    "http://#{webapp_domain}/#confirm/#{token}"
  end

  def cool_readable_date(date)
    date.strftime('%B %-d, %Y at %I:%M %p')
  end
end
