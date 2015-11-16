module Services
module Clients

class Invite < BaseService

  def run
    invite
  end

  def input_params
    [:current_user, :user, :email]
  end

  private

  def invite
    email = @email.presence || !user_email_is_fake? && @user.email
    @user.update_column('email', email) if email && @user.email != email
    @user.invite!(@current_user) if email
  end

  def user_email_is_fake?
    /^u\+\w*@gymcloud\.com$/
      .match(@user.email)
      .present?
  end

end

end
end
