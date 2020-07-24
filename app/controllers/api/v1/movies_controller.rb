class Api::V1::MoviesController < ApplicationController
  def index
    last_updated_movie = Movie.order(:updated_at).last
    @movies = Movie.order(created_at: :desc) \
      if stale?(last_modified: last_updated_movie.updated_at.utc, etag: last_updated_movie.cache_key_with_version)
  end
end
