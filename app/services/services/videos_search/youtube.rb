module Services
module VideosSearch

class Youtube < BaseVideoService

  def search
    yt_search = Yt::Collections::Videos.new
    id_from_url = @q.match(%r{youtube.com/watch.*v=(\w*)})[1]
    if id_from_url.present?
      yt_search = yt_search.where(id: id_from_url)
    else
      yt_search = yt_search.where(q: @q, format: 5) # only embeddable
    end
    yt_search.first(@per_page * @page).last(@per_page)
  end

end

end
end
