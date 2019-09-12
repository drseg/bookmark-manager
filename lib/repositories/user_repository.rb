require 'bcrypt'
require_relative '../repositories/database_connection'
require_relative '../entities/user'

class UserRepository
  def self.create(username:, password:)
    password = encrypt(password)
    result = DatabaseConnection.query("INSERT INTO users (username, password) VALUES('#{username}', '#{password}') RETURNING username, id;")
    User.new(username: username(from: result), id: id(from: result))
  end

  def self.find(id)
    return nil if id.nil?

    result = find_with_predicate("id = '#{id}'")
    User.new(username: username(from: result), id: id(from: result))
  end

  def self.authenticate(username:, password:)
    result = find_with_predicate("username = '#{username}'")
    return nil if result.nil?

    found_password = password(from: result)
    return nil unless found_password == password

    User.new(username: username(from: result), id: id(from: result))
  end

  private

  def self.id(from:)
    from[0]['id']
  end

  def self.username(from:)
    from[0]['username']
  end

  def self.encrypt(password)
    BCrypt::Password.create(password)
  end

  def self.password(from:)
    BCrypt::Password.new(from[0]['password'])
  end

  def self.find_with_predicate(predicate)
    result = DatabaseConnection.query("SELECT * FROM users WHERE #{predicate};")
    return nil unless result.first

    result
  end
end