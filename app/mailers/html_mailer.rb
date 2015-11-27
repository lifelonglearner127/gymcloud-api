class HtmlMailer < ApplicationMailer

  def welcome_new_user(user_id)
    @user = ::User.find(user_id)
    mail(to: @user.email, subject: "We're happy you're here!")
  end

  def program_assigned(email)
    mail(to: email, subject: 'GymCloud')
  end

end
