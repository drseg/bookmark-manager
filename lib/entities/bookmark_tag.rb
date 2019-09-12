class BookmarkTag
  attr_reader :tag_id, :bookmark_id

  def initialize(tag_id:, bookmark_id:)
    @tag_id = tag_id
    @bookmark_id = bookmark_id
  end
end