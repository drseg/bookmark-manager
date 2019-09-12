require './lib/repositories/bookmark_repository'
require './lib/entities/bookmark'
require './spec/test_helpers'

describe BookmarkRepository do
  include_examples 'Test Helpers'

  describe '.all' do
    it 'returns all bookmarks' do
      created_apple = create_apple
      apple = BookmarkRepository.all.first

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
      expect(BookmarkRepository.find(apple.id)).to eq apple
    end

    it 'returns nil if bookmark not found' do
      expect(BookmarkRepository.find('0')).to be_nil
    end
  end

  describe '.update' do
    it 'updates an existing bookmark by id' do
      apple = create_apple
      google = create_google

      BookmarkRepository.update(id: google.id, title: 'test', url: 'test')
      expect(BookmarkRepository.find(apple.id)).to eq apple

      expect(BookmarkRepository.find(google.id)).not_to eq google
      expect(BookmarkRepository.find(google.id).title).to eq 'test'
      expect(BookmarkRepository.find(google.id).url).to eq 'test'
    end
  end

  describe '.delete' do
    it 'deletes the bookmark matching the given id' do
      apple = create_apple
      create_google

      BookmarkRepository.delete(id: apple.id)
      expect(BookmarkRepository.find(apple.id)).to be_nil
    end
  end

  let(:comment_class) { double(:comment_class) }
  let(:tag_class)     { double(:tag_class) }

  describe '#comments' do
    it 'calls .where on the Comment class' do
      apple = create_apple
      expect(comment_class).to receive(:where).with(apple.id)
      apple.comments(comment_class)
    end
  end

  describe '#tags' do
    it 'calls .where on the Comment class' do
      apple = create_apple
      expect(tag_class).to receive(:where).with(apple.id)
      apple.tags(tag_class)
    end
  end
end