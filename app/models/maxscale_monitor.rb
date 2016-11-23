class MaxscaleMonitor < BaseModel
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Validations

  attr_accessor :id, :name, :state, :sampling_interval, :connect_timeout,
                :read_timeout, :write_timeout, :monitored_servers, 
                :maxscale_monitorid, :replication_lag, :detect_stale_master, 
                :monitor, :errors
  
  def initialize(attributes={})
    super
    @id = attributes[:name]
    @errors = ActiveModel::Errors.new(self)
  end

  def self.all
    MaxAdmin::MonitorLoader.new.objects_for
  end

  def self.having_server(server)
    self.all.select {|x| x.monitored_servers.include?(server.server + ":" + server.port.to_s)}
  end

  def self.without_server(server)
    self.all.reject {|x| x.monitored_servers.include?(server.server + ":" + server.port.to_s)}
  end

  def servers
    fmtser = monitored_servers.split(",").collect {|x| x.strip.split(':')}
    fmtser.collect {|x| Server.all.select{|y| y.id == x[0] && y.port == x[1]}}.flatten
  end
end
