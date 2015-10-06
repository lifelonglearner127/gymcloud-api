module Services
module VideosSearch

class Gymcloud < BaseVideoService

  def input_params
    super.concat([:scope, :user])
  end

  private

  def search
    ::Video.send(scope, @user.id).search_by_criteria(@q)
      .page(@page).per(@per_page)
  end

  def scope
    {
      gymcloud: :global_for,
      mine: :owned_by,
      public: :public_for
    }[@scope.to_sym]
  end

end

end
end