class MaxscaleServicesController < ApplicationController
  def index
    @maxscale_services = MaxscaleService.all 
    render json: serialize_models(@maxscale_services)
  end
end
