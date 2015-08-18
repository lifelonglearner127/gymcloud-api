module Services
module Clients

class Invite < BaseService

  input_params :current_user, :user, :email
  run :invite

  private

  def invite
    email = @email.presence || !user_email_is_fake? && @user.email
    User.invite!({email: email}, @current_user)
  end

  def user_email_is_fake?
    /^u\+\w*@gymcloud\.com$/
      .match(@user.email)
      .present?
  end

end

end
end
