module MaxAdmin
  module Command

    def show_all(klass)
      IO.popen("maxadmin show #{substr_all(klass)}").read
    end

    def show_one(klass)
      IO.popen("maxadmin show #{substr_one(klass)}").read
    end
    def list(klass)
      IO.popen("maxadmin list #{substr_all(klass)}").readlines
    end
    private
      def substr_all(klass)
        case klass.to_s
        when "Server"
          return 'servers'
        when "MaxscaleService"
          return 'services'
        when "MaxscaleMonitor"
          return 'monitors'
        when "MaxscaleListener"
          return "listeners"
        end
      end

      def substr_one(klass)
        substr_all(klass).singularize
      end
  end
end
