require_relative './lib/repositories/database_connection'

db_name = ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
DatabaseConnection.setup(db_name)
