class MaxscaleListenersController < ApplicationController
  def index
    @maxscale_listeners = MaxscaleListener.all 
    render json: serialize_models(@maxscale_listeners)
  end
end
