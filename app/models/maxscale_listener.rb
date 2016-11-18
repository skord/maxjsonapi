class MaxscaleListener < BaseModel
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :id, :service_name, :protocol_module, :address, :port, :state, :errors

  def initialize(attributes={})
    super
    @id = attributes[:service_name]
    @errors = ActiveModel::Errors.new(self)
  end

  def self.all
    MaxAdmin::ListLoader.new.objects_for(MaxscaleListener)
  end
end
