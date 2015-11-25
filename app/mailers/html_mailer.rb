class HtmlMailer < ApplicationMailer
  default from: ENV['MAILER_EMAIL']

  def program_assigned(email)
    inline_images(
      'gymcloud-flat-logo.png',
      'program-assigned-icon.png',
      'blue-bg-with-icons.jpg'
    )

    mail(to: email, subject: 'GymCloud')
  end
end
