require './lib/entities/comment'
require './lib/repositories/comment_repository'
require './spec/test_helpers'

describe CommentRepository do
  include_examples 'Test Helpers'

  let(:apple)   { create_apple }
  let(:comment) { CommentRepository.create(text: 'a comment', bookmark_id: apple.id) }

  before :each do
    comment
  end

  describe '.create' do
    it 'creates and returns a new comment' do
      expect(comment.text).to eq 'a comment'
      expect(comment.bookmark_id).to eq apple.id
    end
  end

  describe '.by_id' do
    it 'returns all comments matching the given bookmark id' do
      expect(CommentRepository.where(apple.id).first).to eq comment
    end

    it 'returns nil if no comments found' do
      comment = CommentRepository.create(text: 'a comment', bookmark_id: apple.id)
      expect(CommentRepository.where('0')).to be_empty
    end
  end
end