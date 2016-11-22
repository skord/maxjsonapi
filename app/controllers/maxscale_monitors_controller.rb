class MaxscaleMonitorsController < ApplicationController
  def index
    @monitors = MaxscaleMonitor.all
    render json: serialize_models(@monitors)
  end

  def show
    @monitor = MaxscaleMonitor.find(params[:id])
    render json: serialize_model(@monitor, include: ["servers"])
  end
end
