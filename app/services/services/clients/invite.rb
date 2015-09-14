module Services
module Clients

class Invite

  include BaseService

  input_params :current_user, :user, :email
  run :invite

  private

  def invite
    email = @email.presence || !user_email_is_fake? && @user.email
    user = User.where(email: email).first
    if user.present?
      user.invite!(@current_user)
    else
      User.invite!({email: email}, @current_user)
    end
  end

  def user_email_is_fake?
    /^u\+\w*@gymcloud\.com$/
      .match(@user.email)
      .present?
  end

end

end
end
