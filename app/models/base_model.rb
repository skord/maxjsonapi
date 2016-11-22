class BaseModel
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
