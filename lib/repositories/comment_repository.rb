require_relative '../repositories/database_connection'
require_relative '../entities/comment'

class CommentRepository
  def self.create(text:, bookmark_id:)
    DatabaseConnection.query("INSERT INTO comments (text, bookmark_id) VALUES ('#{text}', '#{bookmark_id}')")
    all.last
  end

  def self.where(bookmark_id)
    result = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{bookmark_id};")
    comments(from: result)
  end

  private

  def self.comments(from:)
    from.map do |c|
      Comment.new(text: c['text'],
                  bookmark_id: c['bookmark_id'],
                  id: c['id'])
    end
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM comments;')
    comments(from: result)
  end
end