module MaxAdmin
  class MonitorLoader
    include MaxAdmin::Command
    def objects_for
      monitors = show_all(MaxscaleMonitor).split(/(?=^Monitor:.+)/m)
      monitors.collect! {|x| x.split("Server information")[0]}
      monitors.collect! {|x| x.split("\n").collect {|y| y.split(":",2)}}
      monitors.collect! {|x| x.collect {|y| y.collect {|z| z.strip}}}
      monitors.collect! {|x| x.collect {|y| {y[0] => y[1]}}}
      monitors.collect! {|x| x.reduce({},:merge)}
      monitors.collect! {|x| x.transform_keys {|k| k.to_s.parameterize.underscore.to_sym}}
      monitors.collect! {|x| MaxscaleMonitor.new(x)}
    end
  end
end
