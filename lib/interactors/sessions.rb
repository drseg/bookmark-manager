require_relative './interactor'
require_relative '../views/new_session_view'
require_relative '../repository/user_repository'

class RequestNewSession < Interactor
  def execute
    view = NewSessionView.new(renderer: @renderer, presenter: nil)
    view.show
  end
end

class CreateNewSession < Interactor
  def execute
    user = UserRepository.authenticate(username: params['username'],
                                       password: params['password'])

    if user.nil?
      flash[:notice] = 'Please check your email or password.'
      redirect '/sessions/new'
    else
      session['user_id'] = user.id
      redirect '/bookmarks'
    end
  end
end

class DestroySession < Interactor
  def execute
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect '/sessions/new'
  end
end