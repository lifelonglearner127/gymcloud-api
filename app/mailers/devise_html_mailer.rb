class DeviseHtmlMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  include InlineImages

  layout 'html_mailer'
  helper :mailer
  default from: ENV['MAILER_EMAIL']
  default template_path: 'devise_html_mailer'

  def invitation_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :invitation_instructions, opts)
  end

end
