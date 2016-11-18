module MaxAdmin
  class Transform < Parslet::Transform
    rule(:root => simple(:r), :items => subtree(:i)) {
      {"#{r}" => i }
    }
    rule(:key => simple(:k), :value => simple(:v)) {
      {"#{k}" => v.to_s}
    }

    rule(:list => simple(:l), :values => subtree(:v)) {
       {"#{l}" => v.collect {|x| x[:value].to_s}}
    }
    rule(:key => simple(:k), :value => sequence(:v)) {
      {"#{k}" => v}
    }
  end
end

