require 'sinatra/base'
require 'pg'

require_relative './lib/bookmark'
require_relative './lib/comment'
require_relative './database_connection_setup'

class BookmarkManager < Sinatra::Base
  set :method_override, true

  get '/' do
    'Bookmark Manager'
  end

  post '/bookmarks' do
    Bookmark.create(title: params['title'], url: params['url'])
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
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

  run! if app_file == $PROGRAM_NAME
end