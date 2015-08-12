class VimeoVideoSearchService

  def initialize(params)
    @query = params[:q]
    @page = params[:page]
    @per_page = params[:per_page] || 50
    @results = []
    @collection = nil
  end

  def search
    response = make_request
    filtered = filter_results(response.items)
    @results.concat filtered

    if @results.count < @page * @per_page
      search
    else
      @results.last(@per_page)
    end
  end

  private

  def make_request
    if @collection.nil?
      client = Vimeo::Client.new(access_token: ENV['VIMEO_TOKEN'])
      @collection = client.search_videos(
        @query,
        page: 1,
        per_page: 50 # vimeo maximum
      )
    else
      @collection.next_page
    end
  end

  def filter_results(results)
    results.reject { |v| v.embed.html.nil? }
  end

end
