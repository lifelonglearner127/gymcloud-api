class YoutubeVideoSearchService

  def initialize(params)
    @query = params[:q]
    @page = params[:page]
    @per_page = params[:per_page] || 50
    @yt_search = Yt::Collections::Videos.new
  end

  def search
    @yt_search = @yt_search.where(q: @query, format: 5) # only embeddable
    @yt_search.first(@per_page * @page).last(@per_page)
  end

end
