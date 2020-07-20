class Api::V1::PurchasesController < ApplicationController

  def create
    service_response = PurchaseContentService.call(current_user, purchase_params)
    return render_error(service_response.failure) unless service_response.success?
    @purchase = service_response.value!
    render :create, status: 201
  end

  private
    def purchase_params
      params.require(:purchase).permit(:content_id, :content_type, :quality, :price).to_hash
    end

    def current_user
      User.find params[:user_id]
    end

end