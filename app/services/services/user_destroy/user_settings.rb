module Services
module UserDestroy

class UserSettings < Base

  private

  def destroy
    @user.user_settings.andand.destroy
  end

end

end
end
