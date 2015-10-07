module Services
module VideosSearch

class Youtube < BaseVideoService

  def search
    yt_search = Yt::Collections::Videos.new
    yt_search = yt_search.where(q: @q, format: 5) # only embeddable
    yt_search.first(@per_page * @page).last(@per_page)
  end

end

end
end