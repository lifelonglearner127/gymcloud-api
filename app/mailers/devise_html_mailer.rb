class DeviseHtmlMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  include InlineImages

  layout 'html_mailer'
  helper :application
  default from: ENV['MAILER_EMAIL']
  default template_path: 'devise_html_mailer'

  def invitation_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :invitation_instructions, opts)
  end

  def each_template(paths, name, &block) #:nodoc:
    templates = lookup_context.find_all(name, paths)
    if templates.empty?
      fail ActionView::MissingTemplate.new(paths, name, paths, false, 'mailer')
    else
      templates = templates.uniq(&:formats)
      attach_images(templates.first.identifier)
      templates.each(&block)
    end
  end

end
