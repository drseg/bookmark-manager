class Comment
  attr_reader :text, :bookmark_id, :id

  def self.create(text:, bookmark_id:)
    DatabaseConnection.query("INSERT INTO comments (text, bookmark_id) VALUES ('#{text}', '#{bookmark_id}')")
    all.last
  end

  def self.where(bookmark_id)
    result = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{bookmark_id};")
    comments(from: result)
  end

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

  private

  def self.all
    result = DatabaseConnection.query('SELECT * FROM comments;')
    comments(from: result)
  end

  def self.comments(from:)
    from.map do |c|
      Comment.new(text: c['text'],
                  bookmark_id: c['bookmark_id'],
                  id: c['id'])
    end
  end
end