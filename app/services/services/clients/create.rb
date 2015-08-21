module Services
module Clients

class Create < BaseService

  input_params :current_user, :attrs
  run :create

  def build_client
    email = @attrs.delete(:email)
    email ||= generate_fake_email
    password = Devise.friendly_token
    @current_user.clients.build(
      email: email,
      password: password,
      password_confirmation: password
    )
  end

  private

  def create
    client = build_client
    client.skip_confirmation!
    client.save!
    Services::UserBootstrap::UserProfile.!(user: client)
    profile_attrs = @attrs.slice('first_name', 'last_name')
    client.user_profile.update_attributes!(profile_attrs)
    create_agreement(client)
    client
  end

  def create_agreement(client)
    @current_user.agreements_as_pro.create!(
      client: client,
      category: AgreementCategory.find_by(symbol: 'trainer'),
      status: :active
    )
  end

  def generate_fake_email
    token = Devise.friendly_token
    "u+#{token}@gymcloud.com"
  end

end

end
end