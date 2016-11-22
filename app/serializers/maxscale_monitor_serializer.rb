class MaxscaleMonitorSerializer
  include JSONAPI::Serializer

  attributes    :name, :state, :sampling_interval, :connect_timeout,
                :read_timeout, :write_timeout, :monitored_servers, 
                :maxscale_monitorid, :replication_lag, :detect_stale_master, 
                :monitor, :errors
  has_many :servers, include_links: false, include_data: true
  def type
    "monitors"
  end
end
