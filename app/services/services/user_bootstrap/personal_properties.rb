module Services
module UserBootstrap

class PersonalProperties < BaseService

  input_params :user
  run :bootstrap

  private

  def bootstrap
    ::GlobalProperty.all.each_with_index do |global_property, position|
      bootstrap_personal_property(global_property, position)
    end
  end

  def bootstrap_personal_property(global_property, position)
    ::PersonalProperty \
      .create_with(
        global_property: global_property,
        person: @user
      )
      .find_or_create_by(
        position: position,
        is_visible: true
      )
  end

end

end
end
