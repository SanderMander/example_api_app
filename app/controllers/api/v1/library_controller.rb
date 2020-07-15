class Api::V1::LibraryController < ApplicationController

  before_action :set_user

  def movies
    render_response(UserLibraryRepository.call(@user.id, 'movies'))
  end

  def seasons
    render_response(UserLibraryRepository.call(@user.id, 'seasons'))
  end

  def remaining
    render_response(UserLibraryRepository.call(@user.id, 'remaining'))
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def render_response(collection)
      if collection.success?
        @collection = collection.value!
        render action: params[:action]
      else
        render_error(collection.failure)
      end
    end
end