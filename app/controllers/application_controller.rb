class ApplicationController < ActionController::API
  include ActionController::Caching
  
  private
    def render_error(error_message)
      render partial: 'api/v1/shared/error_response', locals: {error_message: error_message}, status: 422
    end
end
