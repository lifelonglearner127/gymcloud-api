module InlineImages
  extend ActiveSupport::Concern

  private

  def inline_images(*images)
    images.each do |i|
      attachments.inline[i] = image_file(i)
    end
  end

  def image_file(file_name)
    File.read("#{Rails.root}/app/assets/images/#{file_name}")
  end
end
