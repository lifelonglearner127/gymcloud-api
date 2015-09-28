module Services
module TemplateDuplicating

class Exercise < BaseService

  def run
    duplicate
  end

  def input_params
    [:exercise, :user, :folder_id]
  end

  def defaults
    {folder_id: nil}
  end

  private

  def duplicate
    ::Exercise.create!(prepare_attributes)
  end

  def prepare_attributes
    to_include = %w(name description video_url)
    @exercise.attributes.slice(*to_include).merge(
      is_public: false,
      folder_id: prepare_folder,
      author: @user
    )
  end

  def prepare_folder
    @folder_id ||= ::Folder.find_by(name: 'Exercises', user: @user).id
  end

end

end
end
