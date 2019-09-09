require 'pg'

def setup_test_database
  puts "Setting up test database..."
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("TRUNCATE TABLE bookmarks CASCADE;")
end
