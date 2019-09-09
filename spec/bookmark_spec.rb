require './lib/bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      expect(Bookmark.all).to include('http://www.apple.com')
    end
  end
end