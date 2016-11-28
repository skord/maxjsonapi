class MaxscaleServiceSerializer
  include JSONAPI::Serializer
  attributes  :name, :service, :router, :state, :number_of_router_sessions,
              :number_of_queries_forwarded, :started, :root_user_access,
              :users_data, :total_connections, :currently_connected, 
              :current_no_of_router_sessions, :number_of_queries_forwarded_to_master,
              :number_of_queries_forwarded_to_slave, :number_of_queries_forwarded_to_all
  has_many :servers, include_links: false, include_data: true 
  def type
    "services"
  end
end
