module Services
module SocialLogin

class Create < BaseService

  def run
    create
  end

  def input_params
    [:attrs, :provider, :access_token]
  end

  private

  def create
    provider = ::AuthenticationProvider.where(name: @provider).first
    authentication = provider.user_authentications.where(uid: @attrs.id).first
    existing_user = ::User.where('email = ?', @attrs.emails.first.value).first
    process_user(authentication, existing_user, provider)
  end

  def process_user(authentication, existing_user, provider)
    if authentication
      sign_in_with_existing_authentication(authentication)
    elsif existing_user
      create_authentication_and_sign_in(existing_user, provider)
    else
      create_user_and_authentication_and_sign_in(provider)
    end
  end

  def sign_in_with_existing_authentication(authentication)
    return_access_token(authentication.user)
  end

  def create_authentication_and_sign_in(user, provider)
    ::UserAuthentication.create_from_omniauth(
      @attrs, user, provider, @access_token
    )
    user.confirm
    return_access_token(user)
  end

  def create_user_and_authentication_and_sign_in(provider)
    user = ::User.create_from_omniauth(@attrs)
    user.save! unless user.valid?
    user.become_a_pro!
    Services::UserBootstrap::All.!(user: user)
    update_user_profile(user)
    UserMailer.delay.welcome_new_user(user.id)
    create_authentication_and_sign_in(user, provider)
  end

  def update_user_profile(user)
    names = @attrs.display_name.split(/\s/)
    user.user_profile.update_attributes(
      first_name: names[0],
      last_name: names[1]
    )
  end

  def return_access_token(user)
    Doorkeeper::AccessToken.find_or_create_by(
      application_id: nil,
      resource_owner_id: user.id
    )
  end

  def return_error
    # FIXME: TBD
  end

end

end
end
