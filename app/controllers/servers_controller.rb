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
      render json: serialize_model(new_server), status: :created, location: new_server
    else
      render json: serialize_errors(@server.errors), status: :unprocessable_entity
    end
  end
  
  # PATCH /servers
  def update
    if @server.update(server_attributes, monitor_attributes)
      render json: serialize_model(Server.find(params[:id]))
    else
      @server.reload
      render json: serialize_errors(@server.errors), status: :unprocessable_entity
    end
  end

  def destroy
    @server.destroy 
  end

  private
    def server_params
      params.require(:data).permit(:type, {
         attributes: [:server, :name, :port],
         relationships: {:monitors => {:data => [:type, :id]}}
       }
                                  )
    end
    def server_attributes
      server_params[:attributes] || {}
    end

    def monitor_attributes
      server_params[:relationships][:monitors][:data] || {}
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

end
