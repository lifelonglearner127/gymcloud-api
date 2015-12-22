class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :protect_from_forgery

  def facebook
    social
  end

  def google_oauth2
    social
  end

  def failure
    render json: {errors: [failure_message]}, status: :unprocessable_entity
  end

  private

  def social
    @raw_user = request.env['omniauth.auth']
    if @raw_user.try(:name)
      @raw_user.info.tap do |info|
        info.first_name, info.last_name = info.name.split(/\s+/)
      end
    end
    access_token = Services::SocialLogin::Create.!(attrs: process_user)
    render json: {access_token: access_token.token}
  end

  def process_user
    {
      provider: @raw_user.provider,
      uid: @raw_user.uid,
      is_signup: params['is_signup'],
      email: @raw_user.info.email,
      first_name: @raw_user.info.first_name,
      last_name: @raw_user.info.last_name
    }
  end
end