class HtmlMailer < ApplicationMailer

  layout 'html_mailer'

  def welcome_new_user(user_id)
    @user = ::User.find(user_id)
    mail(to: @user.email, subject: "We're happy you're here!")
  end

  def program_assigned(user_id, program_id)
    email = ::User.find(user_id).email
    @program = ::PersonalProgram.find(program_id)
    mail(to: email, subject: 'GymCloud')
  end

end
