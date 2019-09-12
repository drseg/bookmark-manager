require_relative './database_connection'
require_relative '../entities/bookmark'

class BookmarkRepository
  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks;')
    result.map do |b|
      Bookmark.new(title: b['title'],
                   url: b['url'],
                   id: b['id'])
    end
  end

  def self.find(id)
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
end