require_relative './database_connection_setup'

require 'sinatra/base'
require 'sinatra/flash'

Dir[File.join(__dir__, 'lib/interactors', '*.rb')].each { |file| require_relative file }

class BookmarkManager < Sinatra::Base
  enable :method_override
  enable :sessions
  register Sinatra::Flash

  get('/')                           { execute(Index, params) }
  get('/bookmarks')                  { execute(ViewBookmarks, params) }
  get('/bookmarks/new')              { execute(RequestNewBookmark, params) }
  post('/bookmarks')                 { execute(CreateNewBookmark, params) }
  get('/bookmarks/:id/edit')         { execute(RequestUpdateBookmark, params) }
  patch('/bookmarks/:id')            { execute(UpdateBookmark, params) }
  delete('/bookmarks/:id')           { execute(DeleteBookmark, params) }
  get('/bookmarks/:id/comments/new') { execute(RequestNewComment, params) }
  post('/bookmarks/:id/comments')    { execute(CreateNewComment, params) }
  get('/bookmarks/:id/tags/new')     { execute(RequestNewTag, params) }
  post('/bookmarks/:id/tags')        { execute(CreateNewTag, params) }
  get('/users/new')                  { execute(RequestNewUser, params) }
  post('/users')                     { execute(CreateNewUser, params) }
  get('/sessions/new')               { execute(RequestNewSession, params) }
  post('/sessions')                  { execute(CreateNewSession, params) }
  post('/sessions/destroy')          { execute(DestroySession, params) }

  run! if app_file == $PROGRAM_NAME

  private

  def erb_proc
    proc { |file, options| erb file, options || {} }
  end

  def redirect_proc
    proc { |path| redirect path }
  end

  def execute(class_name, params)
    class_name.new(params: params,
                   session: session,
                   renderer: erb_proc,
                   redirect: redirect_proc,
                   flash: flash).execute
  end
end