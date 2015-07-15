class VimeoVideoSearchService
  def initialize
    @client = Vimeo::Client.new access_token: ENV['VIMEO_TOKEN']
  end

  def search query, params = {}
    @client.search_videos query, params
  end
end
