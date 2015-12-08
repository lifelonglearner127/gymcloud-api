require 'google/api_client/client_secrets'
require 'google/apis/plus_v1'

class Oauth2Controller < ApplicationController

  respond_to :json

  def google_oauth2_uri
    render json: {uri: get_uri(auth_client)}
  end

  def mobile_google_oauth2
    # We are getting 'accessToken' from iOS and 'oauthToken' from Android
    if params['accessToken']
      auth_client.access_token = params['accessToken']
    elsif params['oauthToken']
      auth_client.access_token = params['oauthToken']
    else
      fail ArgumentError.new(errors: ['Token is absent'])
    end
    person = get_person(params['userId'])
    token = Services::SocialLogin::Create.!(
      attrs: person,
      provider: 'google_oauth2',
      access_token: params['accessToken']
    )
    render json: {token: token.token}
  end

  private

  def auth_client
    return @auth_client if @auth_client
    client_secrets = get_client_secrets
    auth_client = client_secrets.to_authorization
    auth_client.scope = [
      'https://www.googleapis.com/auth/plus.login',
      'https://www.googleapis.com/auth/plus.profile.emails.read',
      'https://www.googleapis.com/auth/drive.metadata.readonly'
    ].join(' ')
    auth_client.redirect_uri = ENV['GOOGLE_REDIRECT_URIS']
    @auth_client = auth_client
  end

  def get_uri(auth_client)
    auth_client.authorization_uri.to_s
  end

  def get_person(uid)
    plus = Google::Apis::PlusV1::PlusService.new
    plus.get_person(uid, options: {authorization: auth_client})
  end

  def get_client_secrets
    Google::APIClient::ClientSecrets.new(
      'web' => {
        'auth_provider_x509_cert_url' => 'https://www.googleapis.com/oauth2/v1/certs',
        'auth_uri' => 'https://accounts.google.com/o/oauth2/auth',
        'client_id' => ENV['GOOGLE_CLIENT_ID'],
        'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
        'javascript_origins' => [
            ENV['GOOGLE_JAVASCRIPT_ORIGINS']
        ],
        'redirect_uris' => [
            ENV['GOOGLE_REDIRECT_URIS']
        ],
        'token_uri' => 'https://accounts.google.com/o/oauth2/token'
      }
    )
  end

end