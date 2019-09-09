require './lib/bookmark'
require './spec/test_helpers'

describe Bookmark do
  include_examples 'Test Helpers'

  describe '.all' do
    it 'returns all bookmarks' do
      create_apple
      create_google

      expect(Bookmark.all).to include(apple)
      expect(Bookmark.all).to include(google)
    end
  end
end