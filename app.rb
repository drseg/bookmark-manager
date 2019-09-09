require 'sinatra/base'

class BookmarkManager < Sinatra::Base
  get '/' do
    @text = 'Bookmark Manager'
    erb :index
  end

  run! if app_file == $PROGRAM_NAME
end