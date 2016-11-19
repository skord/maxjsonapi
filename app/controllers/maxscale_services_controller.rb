class MaxscaleServicesController < ApplicationController
  def index
    @maxscale_services = MaxscaleService.all 
    render json: serialize_models(@maxscale_services)
  end
  def show
    @maxscale_service = MaxscaleService.find(params[:id])
    render json: serialize_model(@maxscale_service)
  end
end
