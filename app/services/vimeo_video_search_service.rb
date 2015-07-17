class VimeoVideoSearchService
  def initialize params
    @client = Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
    @query = params[:q]
    @page = params[:page]
    @per_page = params[:per_page]
  end

  def search
    @client.search_videos @query,
      page: @page,
      per_page: @per_page
  end
end
