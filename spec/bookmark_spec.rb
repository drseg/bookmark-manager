require './lib/bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.apple.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

      expect(Bookmark.all).to include('http://www.apple.com')
      expect(Bookmark.all).to include('http://www.google.com')
    end
  end
end