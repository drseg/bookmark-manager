require 'sinatra/base'
require 'pg'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    Bookmark.create(title: params['title'], url: params['url'])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end