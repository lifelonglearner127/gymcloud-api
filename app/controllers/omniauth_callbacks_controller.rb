class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :protect_from_forgery

  def google_oauth2
      info = request.env['omniauth.auth'].info
      @user = ::User.find_by(email: info.email) || new_user(info)
      render json: {access_token: access_token.token}
  end

  def failure
    render json: {errors: [failure_message]}, status: :unprocessable_entity
  end

  private

  def access_token
    Doorkeeper::AccessToken.find_or_create_by!(
      application_id: nil,
      resource_owner_id: @user.id
    )
  end

  def new_user(info)
    user = create_user(info.email)
    user.become_a_pro!
    Services::UserBootstrap::All.!(user: user)
    update_profile(user, info)
    HtmlMailer.delay.welcome_new_user(user.id)
    user
  end

  def create_user(email)
    password = Devise.friendly_token
    user = ::User.new(email: email, password: password)
    user.skip_confirmation!
    user.save!
    user
  end

  def update_profile(user, attrs)
    user.user_profile.update_attributes(
      last_name: attrs.last_name,
      first_name: attrs.first_name
    )
  end
end