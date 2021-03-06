class Server < BaseModel
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Validations

  attr_accessor :id, :name, :server, :status, :protocol, :port,
                :server_version, :node_id, :master_id, :slave_ids,
                :repl_depth, :number_of_connections, :current_no_of_conns,
                :current_no_of_operations, :errors

  validates :server, format: {with: /\A[A-Za-z0-9\.]{1,}\z/, message: "server may only contain alpha-numeric characters and periods"}
  validates :name, format: {with: /\A[A-Za-z0-9]{1,}\z/, message: "name may only contain alpha-numeric characters"}
  validates :port, numericality: {only_integer: true, greater_than_or_equal_to: 1024, less_than_or_equal_to: 65535}
  
  def initialize(attributes={})
    super
    @name = normalize_name(attributes[:name])
    @id = normalize_name(attributes[:id])
    @errors = ActiveModel::Errors.new(self)
  end

  def self.all
     MaxAdmin::ShowLoader.new.objects_for(/Server/,Server)
  end

  def self.find_by_name(name)
    self.all.select {|x| x.name == name}.first
  end

  def monitors
    MaxscaleMonitor.having_server(self)
  end

  def services
    MaxscaleService.having_server(self)
  end

  def services=(new_services)
    @old_service_ids = service_ids
    @avail_service_ids = available_service_ids
    if new_services.is_a?(MaxscaleService)
      new_services = [new_services]
    end
    @new_service_ids = new_services.collect {|x| x.id}
    add_resources_to_server((@new_service_ids & @avail_service_ids))
    remove_resources_from_server((@old_service_ids - @new_service_ids))
    self.services
  end

  def monitors=(new_monitors)
    @old_monitor_ids = monitor_ids
    @avail_monitor_ids = available_monitor_ids
    if new_monitors.is_a?(MaxscaleMonitor)
      new_monitors = [new_monitors]
    end
    @new_monitor_ids = new_monitors.collect {|x| x.id}
    add_resources_to_server((@new_monitor_ids & @avail_monitor_ids))
    remove_resources_from_server((@old_monitor_ids - @new_monitor_ids))
    self.monitors
  end

  def save
    if self.valid?
      cmd = IO.popen("maxadmin create server #{@name} #{@server} #{@port}").read
      if cmd =~ /already exists/
        @errors.add(:base, "server already exists")
        return false
      elsif cmd =~ /Created server/
        return true
      end
    else
      return false
    end
  end

  def update(attributes, monitor_attributes, services_attributes)
    self.server = attributes[:server]
    self.port = attributes[:port]
    new_monitors = monitor_attributes.collect {|x| MaxscaleMonitor.find(x['id'])}
    new_services = services_attributes.collect {|x| MaxscaleService.find(x['id'])}
    if self.valid?
      cmd = IO.popen("maxadmin alter server #{self.id} address=#{self.server} port=#{self.port}").read
      self.monitors = new_monitors
      self.services = new_services
      return true
    else
      return false
    end
  end

  def destroy
    destruction = IO.popen("maxadmin destroy server #{self.id}").read
    if destruction =~ /Destroyed server/
      return true
    else 
      return false
    end
  end

  # private
  def normalize_name(name)
    if name.present? && name.match(/\AServer [[:alnum:]]{1,} \(.*\)\z/)
      return name.scan(/\AServer [[:alnum:]]{1,} \((.*)\)\z/).flatten.first
    else
      return name
    end
  end

  def add_to_monitor(monitor_id)
    monitor = MaxscaleMonitor.find(monitor_id)
    cmd = IO.popen("maxadmin add server #{self.id} #{monitor.id}").read
    if cmd =~ /Added server/
      return true
    else
      return false
    end
  end

  def remove_from_monitor(monitor_id)
    monitor = MaxscaleMonitor.find(monitor_id)
    cmd = IO.popen("maxadmin remove server #{self.id} #{monitor.id}").read
    if cmd =~ /Removed server/
      return true
    else
      return false
    end
  end

  def add_resources_to_server(resource_ids)
    if resource_ids.any?
      cmd = IO.popen("maxadmin add server #{self.id} #{resource_ids.join(' ')}").read
      if cmd =~ /Added server/
        return true
      else
        return false
      end
    end
  end

  def remove_resources_from_server(resource_ids)
    if resource_ids.any?
      cmd = IO.popen("maxadmin remove server #{self.id} #{resource_ids.join(' ')}").read
      if cmd =~ /Added server/
        return true
      else
        return false
      end
    end
  end

  def available_monitors
    MaxscaleMonitor.without_server(self)
  end

  def available_monitor_ids
    available_monitors.collect {|x| x.id}
  end

  def available_services
    MaxscaleService.without_server(self)
  end

  def available_service_ids
    available_services.collect {|x| x.id}
  end

  def monitor_ids
    monitors.collect {|x| x.id}
  end

  def service_ids
    services.collect {|x| x.id}
  end

end

