require './lib/bookmark'
require './spec/test_helpers'

describe Bookmark do
  include_examples 'Test Helpers'

  describe '.all' do
    it 'returns all bookmarks' do
      created_apple = create_apple
      apple = Bookmark.all.first

      expect(apple).to be_a Bookmark
      expect(apple.url).to eq apple_url
      expect(apple.title).to eq apple_title
      expect(apple.id).not_to be_empty
      expect(created_apple).to eq apple
    end
  end

  describe '.by_id' do
    it 'returns a specific bookmark matching the given id' do
      apple = create_apple
      expect(Bookmark.by_id(apple.id)).to eq apple
    end

    it 'returns nil if bookmark not found' do
      expect(Bookmark.by_id('0')).to be_nil
    end
  end

  describe '.update' do
    it 'updates an existing bookmark by id' do
      apple = create_apple
      google = create_google

      Bookmark.update(id: google.id, title: 'test', url: 'test')
      expect(Bookmark.by_id(apple.id)).to eq apple

      expect(Bookmark.by_id(google.id)).not_to eq google
      expect(Bookmark.by_id(google.id).title).to eq 'test'
      expect(Bookmark.by_id(google.id).url).to eq 'test'
    end
  end

  describe '.delete' do
    it 'deletes the bookmark matching the given id' do
      apple = create_apple
      create_google

      Bookmark.delete(id: apple.id)
      expect(Bookmark.by_id(apple.id)).to be_nil
    end
  end
end