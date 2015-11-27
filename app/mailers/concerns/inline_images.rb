module InlineImages
  extend ActiveSupport::Concern

  private

  def inline_images(images)
    images.each do |i|
      attachments.inline[i] = image_file(i)
    end
  end

  def image_file(file_name)
    File.read("#{Rails.root}/app/assets/images/#{file_name}")
  end

  def attach_images(file_name)
    regex = /attachments\[\'(.*)\'\]/
    images = File.read(file_name).scan(regex).flatten
    inline_images(images)
  end

end
