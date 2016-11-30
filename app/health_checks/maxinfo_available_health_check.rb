require 'open-uri'
class MaxinfoAvailableHealthCheck
  def self.perform_check
    if ENV['MAXSCALE_MAXINFO_IP_PORT'].blank?
      return "MAXSCALE_MAXINFO_IP_PORT environmental not set"
    else
      begin
        open("http://#{ENV['MAXSCALE_MAXINFO_IP_PORT']}").read
        return ""
      rescue => exception
        return "could not reach Maxinfo @ http://#{ENV['MAXSCALE_MAXINFO_IP_PORT']}"
      end
    end
  end
end