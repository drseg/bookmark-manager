require './lib/bookmark_tag'

describe BookmarkTag do
  include_examples 'Test Helpers'

  describe '.create' do
    it 'creates and returns a BookmarkTag' do
      tag = Tag.create(text: '')
      apple = create_apple
      bookmark_tag = BookmarkTag.create(tag_id: tag.id,
                                        bookmark_id: apple.id)

      expect(bookmark_tag.tag_id).to eq tag.id
      expect(bookmark_tag.bookmark_id).to eq apple.id
    end
  end
end