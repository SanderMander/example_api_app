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
      collection = UserLibraryRepository.call(@user.id, params[:action])
      return render_error(collection.failure) unless collection.success?
      @collection = collection.value!
    end

end