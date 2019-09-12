class Tag
  attr_reader :text, :id

  def initialize(text:, id:)
    @text = text
    @id = id
  end

  def ==(other)
    other.class == self.class && other.state == state
  end

  protected

  def state
    instance_variables.map { |v| instance_variable_get v }
  end
end