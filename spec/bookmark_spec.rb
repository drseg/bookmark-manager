require './lib/bookmark'
require './spec/test_helpers'

describe Bookmark do
  include_examples 'Test Helpers'

  describe '.all' do
    it 'returns all bookmarks' do
      create_apple

      apple = Bookmark.all.first

      expect(apple).to be_a Bookmark
      expect(apple.url).to eq apple_url
      expect(apple.title).to eq apple_title
      expect(apple.id).not_to be_empty
    end
  end

  describe '.by_id' do
    it 'returns a specific bookmark matching the given id' do
      create_apple
      apple = Bookmark.all.first
      expect(Bookmark.by_id(apple.id)).to eq apple
    end

    it 'returns nil if bookmark not found' do
      expect(Bookmark.by_id('0')).to be_nil
    end
  end

  describe '.delete' do
    it 'deletes the bookmark matching the given id' do
      create_apple
      create_google

      apple = Bookmark.all.first
      Bookmark.delete(id: apple.id)

      expect(Bookmark.by_id(apple.id)).to be_nil
    end
  end
end