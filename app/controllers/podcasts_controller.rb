class PodcastsController < ApplicationController

  respond_to :rss

  def index
    @episodes = ::PodcastEpisode.published

    respond_to { |format| format.rss }
  end

end
