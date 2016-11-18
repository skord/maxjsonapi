module MaxAdmin
  class ListLoader
  include MaxAdmin::Command

    def objects_for(klass)
      raw = list(klass)
      keys = raw[2].split("|").collect {|key| key.strip}
      values = raw[4..-3].collect {|vals| vals.strip.split("|")}.collect {|x| x.collect {|y|y.strip}}
      values.collect! {|vals| vals.each_with_index.collect {|val,i| {keys.at(i) => val}}}
      hashes = values.collect! {|vals| vals.reduce({}, :merge)}.collect {|vals| vals.transform_keys {|key| key.to_s.parameterize.underscore.to_sym}}
      hashes.collect {|vals| klass.new(vals)}
    end
  end
end
