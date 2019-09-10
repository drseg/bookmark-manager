require 'sinatra/base'
require 'sinatra/flash'
require 'pg'

require_relative './lib/bookmark'
require_relative './lib/comment'
require_relative './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :method_override
  enable :sessions
  register Sinatra::Flash

  get '/' do
    'Bookmark Manager'
  end

  post '/bookmarks' do
    Bookmark.create(title: params['title'], url: params['url'])
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    @user = User.find(session['user_id'])
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(params['id'])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params['id'], title: params['title'], url: params['url'])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params['id'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params['id']
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params['comment'], bookmark_id: params['id'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params['id']
    erb :'tags/new'
  end

  post '/bookmarks/:id/tags' do
    tag = Tag.create(text: params['tag'])
    BookmarkTag.create(tag_id: tag.id, bookmark_id: params['id'])
    redirect '/bookmarks'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(username: params['username'],
                       password: params['password'])
    session['user_id'] = user.id
    redirect '/bookmarks'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
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

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect '/sessions/new'
  end

  run! if app_file == $PROGRAM_NAME
end