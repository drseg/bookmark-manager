class Bookmark
  attr_reader :title, :url, :id

  def initialize(title:, url:, id:)
    @title = title
    @url = url
    @id = id
  end

  def comments(comment_class = CommentRepository)
    comment_class.where(id)
  end

  def tags(tag_class = TagRepository)
    tag_class.where(id)
  end

  def ==(other)
    other.class == self.class && other.state == state
  end

  protected

  def state
    instance_variables.map { |v| instance_variable_get v }
  end
end