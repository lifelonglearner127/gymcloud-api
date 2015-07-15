class VimeoVideoSearchService
  def initialize params
    @client = Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
    @query  = params[:q]
    @params = params.slice!(:q)
  end

  def search
    @client.search_videos @query, @params
  end
end
