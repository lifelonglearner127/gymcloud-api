class DeviseHtmlMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  include InlineImages

  layout 'html_mailer'
  helper :application
  default from: ENV['MAILER_EMAIL']
  default template_path: 'devise_html_mailer'

  def invitation_instructions(record, token, opts = {})
    @token = token
    inline_images(
      'logo-white.png',
      'get-started-arrow.png',
      'blue-bg-with-icons.jpg'
    )
    devise_mail(record, :invitation_instructions, opts)
  end
end
