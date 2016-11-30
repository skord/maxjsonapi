class ServerSerializer
  include JSONAPI::Serializer
  
  attributes    :name, :server, :status, :protocol, :port,
                :server_version, :node_id, :master_id, :slave_ids,
                :repl_depth, :number_of_connections, :current_no_of_conns,
                :current_no_of_operations
  has_many :monitors, include_links: false, include_data: true
  has_many :services, include_links: false, include_data: true
end
