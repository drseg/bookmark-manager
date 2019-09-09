require 'sinatra/base'
require 'pg'
require_relative './lib/bookmark'

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
    @bookmark = Bookmark.by_id(params['id'])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params['id'], title: params['title'], url: params['url'])
    p Bookmark.all
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params['id'])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end