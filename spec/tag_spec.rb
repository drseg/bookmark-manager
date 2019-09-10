require './lib/tag'

describe Tag do
  include_examples 'Test Helpers'

  describe '.create' do
    it 'creates and returns a new tag' do
      apple = create_apple
      tag = Tag.create(text: 'test tag')
      expect(tag).to be_a Tag
      expect(tag.text).to eq 'test tag'
    end
  end

  describe '.where' do
    it 'returns tags by bookmark id' do
      apple = create_apple
      google = create_google
      tag = Tag.create(text: 'test tag')

      BookmarkTag.create(tag_id: tag.id, bookmark_id: apple.id)
      BookmarkTag.create(tag_id: tag.id, bookmark_id: google.id)

      expect(Tag.where(google.id).first).to eq tag
      expect(Tag.where(apple.id).first).to eq tag
    end
  end
end