module Services
module UserBootstrap

class All < BaseService

  def run
    bootstrap
  end

  def input_params
    [:user]
  end

  private

  def bootstrap
    Services::UserBootstrap::UserProfile.!(user: @user)
    Services::UserBootstrap::UserSettings.!(user: @user)
    Services::UserBootstrap::PersonalProperties.!(user: @user)
    Services::UserBootstrap::Folders.!(user: @user)
    @user.update_attributes!(is_active: true)
  end

end

end
end
