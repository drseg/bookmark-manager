require_relative '../views/sinatra_view'

class BookmarksView < SinatraView
  def initialize(renderer:, presenter:)
    @view = :'bookmarks/index'
    super(renderer: renderer, presenter: presenter)
  end
end