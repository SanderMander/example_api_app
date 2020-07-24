class Api::V1::SeasonsController < ApplicationController
  def index
    last_updated_season = Season.order(:updated_at).last
    @seasons = Season.order(created_at: :desc) \
      if stale?(last_modified: last_updated_season.updated_at.utc, etag: last_updated_season.cache_key_with_version)
  end
end
