class Array
  def partial_include? search
    self.each do |e|
      return true if search.include?(e.to_s)
    end
    return false
  end
end