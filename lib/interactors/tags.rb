require_relative './interactor'
require_relative '../views/new_tag_view'
require_relative '../entities/tag'
require_relative '../entities/bookmark_tag'
require_relative '../repository/tag_repository'
require_relative '../repository/bookmark_tag_repository'

class RequestNewTag < Interactor
  def execute
    bookmark_id = params['id']
    presenter = Presenter.new(bookmark_id: bookmark_id)
    view = NewTagView.new(renderer: @renderer, presenter: presenter)
    view.show
  end
end

class CreateNewTag < Interactor
  def execute
    tag = TagRepository.create(text: params['tag'])
    BookmarkTagRepository.create(tag_id: tag.id, bookmark_id: params['id'])
    redirect '/bookmarks'
  end
end