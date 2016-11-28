class MaxscaleService < BaseModel
  ASSIGNABLE_ROUTER_TYPES = ["readconnroute", "readwritesplit",
                             "schemarouter", "binlogrouter", "avrorouter"]
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :id, :name, :service, :router, :state, :number_of_router_sessions,
                :number_of_queries_forwarded, :started, :root_user_access, :backend_databases,
                :users_data, :total_connections, :currently_connected, :errors,
                :current_no_of_router_sessions, :number_of_queries_forwarded_to_master,
                :number_of_queries_forwarded_to_slave, :number_of_queries_forwarded_to_all
  
  def initialize(attributes={})
    super
    @name = attributes[:service]
    @id = attributes[:service]
    @errors = ActiveModel::Errors.new(self)
  end

  
  def self.all
    MaxAdmin::ShowLoader.new.objects_for(/Service/,MaxscaleService)
  end

  def self.server_assignable
    self.all.select {|x| ASSIGNABLE_ROUTER_TYPES.partial_include?(x.router)}  
  end

  def self.find_by_name(name)
    self.all.select {|x| x.name == name}.first
  end

  def self.having_server(server)
    self.all.select {|x| x.server_ids.include?(server.id)}
  end

  def self.without_server(server)
    self.all.reject {|x| x.server_ids.include?(server.id)}
  end

  def servers
    keys  = backend_databases.collect {|x| x.split(" ",2).collect {|y| y.split(":")}.flatten}
    keys.collect {|x| Server.all.select {|y| y.id == x[0] && y.port == x[1] && y.protocol == x[3].strip}}.flatten
  end

  def server_ids
    servers.collect {|x| x.id}
  end
end