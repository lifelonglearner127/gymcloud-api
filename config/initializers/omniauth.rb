Rails.application.config.middleware.use OmniAuth::Builder do

  provider :developer unless Rails.env.production?

  provider :facebook,
    ENV['FACEBOOK_APP_ID'],
    ENV['FACEBOOK_SECRET'],
    {
      scope: 'email , user_birthday',
      image_size: 'large'
    }

  provider :google_oauth2,
    ENV['GOOGLE_APP_ID'],
    ENV['GOOGLE_SECRET'],
    {
      scope: 'email profile'
    }

end
