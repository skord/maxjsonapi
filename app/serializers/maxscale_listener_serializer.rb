class MaxscaleListenerSerializer
  include JSONAPI::Serializer
  attributes :id, :service_name, :protocol_module, :address, :port, :state, :errors
  def type
    "listeners"
  end
end
