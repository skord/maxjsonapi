class MaxadminPresentHealthCheck
    def self.perform_check
        maxadmins = []
        ENV['PATH'].split(':').each do |dir|
            maxadmins += Dir.glob(File.join(dir,'maxadmin'))
        end
        if maxadmins.empty?
            return "no maxadmin utility found"
        else
            return ""
        end
    end
end