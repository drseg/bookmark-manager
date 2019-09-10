require 'bcrypt'

class User
  attr_reader :username, :id

  def self.create(username:, password:)
    password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (username, password) VALUES('#{username}', '#{password}') RETURNING username, id;")
    User.new(username: result[0]['username'], id: result[0]['id'])
  end

  def self.find(id)
    return nil if id.nil?

    result = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}';")
    User.new(username: result[0]['username'], id: result[0]['id'])
  end

  private

  def initialize(username:, id:)
    @username = username
    @id = id
  end
end