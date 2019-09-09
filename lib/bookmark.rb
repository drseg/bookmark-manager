require 'pg'

class Bookmark
  attr_reader :url, :title

  def self.all
    result = connection.exec('SELECT * FROM bookmarks;')
    result.map { |b| Bookmark.new(title: b['title'], url: b['url']) }
  end

  def self.create(title:, url:)
    connection.exec("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{url}')")
  end

  def initialize(title:, url:)
    @title = title
    @url = url
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