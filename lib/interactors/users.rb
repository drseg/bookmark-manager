require_relative '../repository/user_repository'
require_relative './interactor'
require_relative '../views/new_user_view'

class RequestNewUser < Interactor
  def execute
    presenter = Presenter.new
    view = NewUserView.new(renderer: @renderer, presenter: presenter)
    view.show
  end
end

class CreateNewUser < Interactor
  def execute
    user = UserRepository.create(username: params['username'],
                                 password: params['password'])
    session['user_id'] = user.id
    redirect '/bookmarks'
  end
end