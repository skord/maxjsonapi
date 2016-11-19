class Server < BaseModel
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Validations

  attr_accessor :id, :name, :server, :status, :protocol, :port,
                :server_version, :node_id, :master_id, :slave_ids,
                :repl_depth, :number_of_connections, :current_no_of_conns,
                :current_no_of_operations, :errors

  validates :server, presence: true, format: {with: /\A[A-Za-z0-9\.]{1,}\z/}
  validates :name, presence: true, format: {with: /\A[A-Za-z0-9\.]{1,}\z/}
  validates :port, presence: true, numericality: {integer: true, greater_than_or_equal_to: 1024, less_than_or_equal_to: 65535}
  
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

  def self.where(query_hash)
    result = []
    sets = query_hash.collect {|k,v| self.all.select {|x| x.send(k.to_s) == v}}
    sets.inject(:&)
  end

  def save
    cmd = IO.popen("maxadmin create server #{@name} #{@server} #{@port}").read
    if cmd =~ /already exists/
      @errors.add(:base, "server already exists")
      return false
    elsif cmd =~ /Created server/
      return true
    end
  end

  private
  def normalize_name(name)
    if name.present? && name.match(/\AServer [[:alnum:]]{1,} \(.*\)\z/)
      return name.scan(/\AServer [[:alnum:]]{1,} \((.*)\)\z/).flatten.first
    else
      return name
    end
  end

end

