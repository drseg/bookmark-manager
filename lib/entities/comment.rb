class Comment
  attr_reader :text, :bookmark_id, :id

  def initialize(text:, bookmark_id:, id:)
    @text = text
    @bookmark_id = bookmark_id
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