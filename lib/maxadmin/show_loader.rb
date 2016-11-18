module MaxAdmin
  class ShowLoader
  include MaxAdmin::Command

    def objects_for(regex, klass)
      parsed = MaxAdmin::Parser.new.parse(show_all(klass))
      tree= MaxAdmin::Transform.new.apply(parsed)
      pruned_tree = tree.select {|x| x.keys.any? {|k| k =~ regex}}
      values = pruned_tree.collect {|x| x.values[0].reduce({}, :merge)
        .transform_keys {|key| key.to_s.parameterize.underscore.to_sym}
        .merge({:name => x.keys[0], :id => x.keys[0]})}
      values.collect {|val| klass.new(val)}
    end
  end
end
