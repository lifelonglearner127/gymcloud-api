class HtmlMailerPreview < ActionMailer::Preview
  def invitation
    HtmlMailer.invitation
  end
end
