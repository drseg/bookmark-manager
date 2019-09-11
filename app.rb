require 'sinatra/base'
require 'sinatra/flash'
require 'pg'

require_relative './lib/bookmark'
require_relative './lib/comment'
require_relative './lib/tag'
require_relative './lib/user'
require_relative './database_connection_setup'

class Controller
  def initialize(params:, session:, renderer:, redirect:, flash:)
    @params = params
    @session = session
    @renderer = renderer
    @redirect = redirect
    @flash = flash
  end

  def execute
    raise 'Controller is abstract'
  end

  def flash
    @flash
  end

  def params
    @params
  end

  def session
    @session
  end

  protected

  def render(file)
    @renderer.call(file, scope: self)
  end

  def redirect(path)
    @redirect.call(path)
  end
end

class Index < Controller
  def execute
    redirect '/bookmarks'
  end
end

class ViewBookmarks < Controller
  def execute
    @bookmarks = Bookmark.all
    @user = User.find(session['user_id'])
    render :'bookmarks/index'
  end
end

class RequestNewBookmark < Controller
  def execute
    render :'bookmarks/new'
  end
end

class CreateNewBookmark < Controller
  def execute
    Bookmark.create(title: params['title'], url: params['url'])
    redirect '/bookmarks'
  end
end

class RequestUpdateBookmark < Controller
  def execute
    @bookmark = Bookmark.find(params['id'])
    render :'bookmarks/edit'
  end
end

class DeleteBookmark < Controller
  def execute
    Bookmark.delete(id: params['id'])
    redirect '/bookmarks'
  end
end

class UpdateBookmark < Controller
  def execute
    Bookmark.update(id: params['id'], title: params['title'], url: params['url'])
    redirect '/bookmarks'
  end
end

class RequestNewComment < Controller
  def execute
    @bookmark_id = params['id']
    render :'comments/new'
  end
end

class CreateNewComment < Controller
  def execute
    Comment.create(text: params['comment'], bookmark_id: params['id'])
    redirect '/bookmarks'
  end
end

class RequestNewTag < Controller
  def execute
    @bookmark_id = params['id']
    render :'tags/new'
  end
end

class CreateNewTag < Controller
  def execute
    tag = Tag.create(text: params['tag'])
    BookmarkTag.create(tag_id: tag.id, bookmark_id: params['id'])
    redirect '/bookmarks'
  end
end

class RequestNewUser < Controller
  def execute
    render :'users/new'
  end
end

class CreateNewUser < Controller
  def execute
    user = User.create(username: params['username'],
                       password: params['password'])
    session['user_id'] = user.id
    redirect '/bookmarks'
  end
end

class RequestNewSession < Controller
  def execute
    render :'sessions/new'
  end
end

class CreateNewSession < Controller
  def execute
    user = User.authenticate(username: params['username'],
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

class DestroySession < Controller
  def execute
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect '/sessions/new'
  end
end

class BookmarkManager < Sinatra::Base
  enable :method_override
  enable :sessions
  register Sinatra::Flash

  get('/')                           { execute(Index, params: params) }
  get('/bookmarks')                  { execute(ViewBookmarks, params: params) }
  get('/bookmarks/new')              { execute(RequestNewBookmark, params: params) }
  post('/bookmarks')                 { execute(CreateNewBookmark, params: params) }
  get('/bookmarks/:id/edit')         { execute(RequestUpdateBookmark, params: params) }
  patch('/bookmarks/:id')            { execute(UpdateBookmark, params: params) }
  delete('/bookmarks/:id')           { execute(DeleteBookmark, params: params) }
  get('/bookmarks/:id/comments/new') { execute(RequestNewComment, params: params) }
  post('/bookmarks/:id/comments')    { execute(CreateNewComment, params: params) }
  get('/bookmarks/:id/tags/new')     { execute(RequestNewTag, params: params) }
  post('/bookmarks/:id/tags')        { execute(CreateNewTag, params: params) }
  get('/users/new')                  { execute(RequestNewUser, params: params) }
  post('/users')                     { execute(CreateNewUser, params: params) }
  get('/sessions/new')               { execute(RequestNewSession, params: params) }
  post('/sessions')                  { execute(CreateNewSession, params: params) }
  post('/sessions/destroy')          { execute(DestroySession, params: params) }

  run! if app_file == $PROGRAM_NAME

  private

  def erb_proc
    proc { |file, options| erb file, options || {} }
  end

  def redirect_proc
    proc { |path| redirect path }
  end

  def execute(class_name, params:)
    class_name.new(params: params,
                   session: session,
                   renderer: erb_proc,
                   redirect: redirect_proc,
                   flash: flash).execute
  end
end