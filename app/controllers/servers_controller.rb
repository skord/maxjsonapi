class ServersController < ApplicationController
  before_action :set_server, only: [:show, :update, :destroy]

  # GET /servers
  def index
    @servers = Server.all

    render json: serialize_models(@servers)
  end

  # GET /servers/1
  def show
    render json: serialize_model(@server)
  end

  # POST /servers
  def create
    @server = Server.new(server_attributes)

    if @server.save
      new_server = Server.find_by_name(@server.name)
      render json: serialize_model(new_server), status: :created
    else
      render json: serialize_errors(@server.errors), status: :unprocessable_entity
    end
  end

  private
    def server_params
      params.require(:data).permit(:type, {
        attributes: [:server, :name, :port]
      })
    end
    def server_attributes
      server_params[:attributes] || {}
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

end
