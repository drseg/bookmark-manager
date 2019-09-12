require './lib/entities/bookmark_tag'
require './lib/repository/bookmark_tag_repository'
require './lib/repository/tag_repository'

describe BookmarkTagRepository do
  include_examples 'Test Helpers'

  describe '.create' do
    it 'creates and returns a BookmarkTag' do
      tag = TagRepository.create(text: '')
      apple = create_apple
      bookmark_tag = BookmarkTagRepository.create(tag_id: tag.id,
                                                  bookmark_id: apple.id)

      expect(bookmark_tag.tag_id).to eq tag.id
      expect(bookmark_tag.bookmark_id).to eq apple.id
    end
  end
end