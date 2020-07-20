class Api::V1::LibraryController < ApplicationController

  before_action :set_user, :load_collection

  def movies
    @movies = @collection[:results]
  end

  def seasons
    @seasons = @collection[:results]
  end

  def all
    @seasons = @collection[:results][:seasons]
    @movies = @collection[:results][:movies]
  end

  def remaining
    @seasons = @collection[:results][:seasons]
    @movies = @collection[:results][:movies]
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def load_collection
      last_purchase = @user.purchases.order(updated_at: :asc).last
      # Take page from cache in case if user purchases weren't changed
      if last_purchase.blank? || 
          stale?(last_modified: last_purchase.updated_at.utc, etag: last_purchase.cache_key_with_version)
        collection = UserLibraryRepository.call(@user.id, params[:action])
        return render_error(collection.failure) unless collection.success?
        @collection = collection.value!
      end
    end

end