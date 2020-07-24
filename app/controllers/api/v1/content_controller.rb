class Api::V1::ContentController < ApplicationController
  def index
    last_updated_movie = Movie.order(:updated_at).last
    last_updated_season = Season.order(:updated_at).last
    last_updated_content = if last_updated_movie.updated_at > last_updated_season.updated_at
      last_updated_movie
    else
      last_updated_season
    end
    if stale?(last_modified: last_updated_content.updated_at.utc, etag: last_updated_content.cache_key_with_version)
      @movies = Movie.order(created_at: :desc)
      @seasons = Season.order(created_at: :desc)
    end
  end
end
