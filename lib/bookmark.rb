class Bookmark
  attr_reader :title, :url, :id

  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks;')
    result.map do |b| 
      Bookmark.new(title: b['title'],
                   url: b['url'],
                   id: b['id'])
    end
  end

  def self.by_id(id)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};").first
    return if result.nil?

    Bookmark.new(title: result['title'], 
                 url: result['url'], 
                 id: result['id'])
  end

  def self.create(title:, url:)
    DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{url}')")
    all.last
  end

  def self.update(id:, title:, url:)
    DatabaseConnection.query("UPDATE bookmarks SET TITLE = '#{title}', URL = '#{url}' WHERE id = #{id};")
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id};")
  end

  def initialize(title:, url:, id:)
    @title = title
    @url = url
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