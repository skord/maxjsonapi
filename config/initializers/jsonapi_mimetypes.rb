module JSONAPI
  MIMETYPE = "application/vnd.api+json"
end
Mime::Type.unregister(:json)
Mime::Type.register(JSONAPI::MIMETYPE, :json)
ActionDispatch::Http::Parameters::DEFAULT_PARSERS[Mime::Type.lookup(JSONAPI::MIMETYPE)] = lambda do |body|
  JSON.parse(body)
end
