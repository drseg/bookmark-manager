require 'pg'

class Bookmark
  attr_reader :title, :url, :id

  def self.all
    result = connection.exec('SELECT * FROM bookmarks;')
    result.map { |b| Bookmark.new(title: b['title'], url: b['url'], id: b['id']) }
  end

  def self.by_id(id)
    result = connection.exec("SELECT * FROM bookmarks WHERE id = #{id};").first
    return if result.nil?

    Bookmark.new(title: result['title'], url: result['url'], id: result['id'])
  end

  def self.create(title:, url:)
    connection.exec("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{url}')")
    all.last
  end

  def self.update(id:, title:, url:)
    connection.exec("UPDATE bookmarks SET TITLE = '#{title}', URL = '#{url}' WHERE id = #{id};")
  end

  def self.delete(id:)
    connection.exec("DELETE FROM bookmarks WHERE id = #{id};")
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

  private

  def self.connection
    db_name = ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
    @connection ||= PG.connect(dbname: db_name)
    @connection
  end
end