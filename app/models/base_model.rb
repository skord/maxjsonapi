class BaseModel
  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat vars
    super(*vars)
  end

  def self.attributes
    @attributes - [:validation_context,:errors]
  end

  def attributes
    self.class.attributes
  end

  def attributes_hash
    attributes.collect {|x| {x => self.send(x)}}.reduce({}, :merge)
  end

  def self.find(id)
    self.all.select {|x| x.id == id}.first
  end

  def reload
    self.class.find(self.id)
  end
  def persisted?
    id.present?
  end
end