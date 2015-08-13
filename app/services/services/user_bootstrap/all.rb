module Services
module UserBootstrap

class All < BaseService

  input_params :user
  run :bootstrap

  private

  def bootstrap
    Services::UserBootstrap::UserProfile.!(user: @user)
    Services::UserBootstrap::PersonalProperties.!(user: @user)
  end

end

end
end
