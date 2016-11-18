class MaxscaleService < BaseModel
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

  def self.find_by_name(name)
    self.all.select {|x| x.name == name}.first
  end

  def self.where(query_hash)
    result = []
    sets = query_hash.collect {|k,v| self.all.select {|x| x.send(k.to_s) == v}}
    sets.inject(:&)
  end

end

