class ApplicationMailer < ActionMailer::Base

  default from: ENV.fetch('MAILER_EMAIL')
  layout 'mailer'

end
