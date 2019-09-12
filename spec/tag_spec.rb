require './lib/entities/tag'
require './lib/repository/tag_repository'
require './lib/repository/bookmark_tag_repository'

describe TagRepository do
  include_examples 'Test Helpers'

  describe '.create' do
    it 'creates and returns a new tag' do
      apple = create_apple
      tag = TagRepository.create(text: 'test tag')
      expect(tag).to be_a Tag
      expect(tag.text).to eq 'test tag'
    end
  end

  describe '.where' do
    it 'returns tags by bookmark id' do
      apple = create_apple
      google = create_google
      tag = TagRepository.create(text: 'test tag')

      BookmarkTagRepository.create(tag_id: tag.id, bookmark_id: apple.id)
      BookmarkTagRepository.create(tag_id: tag.id, bookmark_id: google.id)

      expect(TagRepository.where(google.id).first).to eq tag
      expect(TagRepository.where(apple.id).first).to eq tag
    end
  end
end