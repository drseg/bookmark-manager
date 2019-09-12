require_relative './interactor'
require_relative '../repositories/bookmark_repository'
require_relative '../repositories/user_repository'
require_relative '../views/bookmarks_view'
require_relative '../views/new_bookmark_view'
require_relative '../views/update_bookmark_view'
require_relative '../presenters/presenter'

class ViewBookmarks < Interactor
  def execute
    bookmarks = BookmarkRepository.all
    user = UserRepository.find(session['user_id'])

    presenter = Presenter.new(bookmarks: bookmarks, user: user)
    view = BookmarksView.new(renderer: @renderer, presenter: presenter)
    view.show
  end
end

class RequestNewBookmark < Interactor
  def execute
    presenter = Presenter.new
    view = NewBookmarkView.new(renderer: @renderer, presenter: presenter)
    view.show
  end
end

class CreateNewBookmark < Interactor
  def execute
    BookmarkRepository.create(title: params['title'], url: params['url'])
    redirect '/bookmarks'
  end
end

class RequestUpdateBookmark < Interactor
  def execute
    bookmark = BookmarkRepository.find(params['id'])

    presenter = Presenter.new(bookmark: bookmark)
    view = UpdateBookmarkView.new(renderer: @renderer, presenter: presenter)
    view.show
  end
end

class DeleteBookmark < Interactor
  def execute
    BookmarkRepository.delete(id: params['id'])
    redirect '/bookmarks'
  end
end

class UpdateBookmark < Interactor
  def execute
    BookmarkRepository.update(id: params['id'], title: params['title'], url: params['url'])
    redirect '/bookmarks'
  end
end