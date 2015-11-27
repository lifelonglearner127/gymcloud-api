class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILER_EMAIL']
  layout 'html_mailer'
  include InlineImages
end
