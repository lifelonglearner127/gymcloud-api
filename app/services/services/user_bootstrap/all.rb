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
    Services::UserBootstrap::PersonalProperties.!(user: @user)
    Services::UserBootstrap::Folders.!(user: @user)
  end

end

end
end
