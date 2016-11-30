HealthCheck.setup do |config|
  config.add_custom_check do
    MaxadminPresentHealthCheck.perform_check
  end
  config.add_custom_check do
    MaxinfoAvailableHealthCheck.perform_check
  end
end