class ApplicationController < ActionController::API
  def serialize_model(model, options ={})
    options[:is_collection] = false
    JSONAPI::Serializer.serialize(model, options)
  end
  def serialize_models(models, options = {})
    options[:is_collection] = true
    JSONAPI::Serializer.serialize(models, options)
  end
  def serialize_errors(errors, options = {})
    JSONAPI::Serializer.serialize_errors(errors)
  end
end
