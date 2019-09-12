require_relative './interactor'
require_relative '../entities/comment'
require_relative '../views/new_comment_view'
require_relative '../repositories/comment_repository'

class RequestNewComment < Interactor
  def execute
    bookmark_id = params['id']
    presenter = Presenter.new(bookmark_id: bookmark_id)
    view = NewCommentView.new(renderer: @renderer, presenter: presenter)
    view.show
  end
end

class CreateNewComment < Interactor
  def execute
    CommentRepository.create(text: params['comment'], bookmark_id: params['id'])
    redirect '/bookmarks'
  end
end