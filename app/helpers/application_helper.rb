module ApplicationHelper

  def inivitation_url(token, user)
    domain = ENV['DOMAIN_WEBAPP']
    params = {
      invitation_token: token,
      first_name: user.user_profile.first_name,
      last_name: user.user_profile.last_name,
      email: user.email,
      client_id: user.id,
      user_profile_id: user.user_profile.id
    }.to_param
    "http://#{domain}/#signup?#{params}"
  end

end
