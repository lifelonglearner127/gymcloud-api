class PreviewController < ApplicationController
  def invitation_instructions
    @resource = User.first
    render template: 'devise/mailer/invitation_instructions'
  end
end
