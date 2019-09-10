require_relative './database_connection'

class Tag
  attr_reader :text, :id

  def self.create(text:)
    result = DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{text}') RETURNING id, content;")
    Tag.new(text: result[0]['content'], id: result[0]['id'])
  end

  def self.where(bookmark_id)
    result = DatabaseConnection.query("SELECT tags.id, content FROM bookmark_tags INNER JOIN tags ON tags.id = bookmark_tags.tag_id WHERE bookmark_tags.bookmark_id = '#{bookmark_id}';")
    result.map do |tag|
      Tag.new(text: tag['content'], id: tag['id'])
    end
  end

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