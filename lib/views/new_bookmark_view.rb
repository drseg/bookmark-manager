require_relative '../views/sinatra_view'

class NewBookmarkView < SinatraView
  def initialize(renderer:, presenter:)
    @view = :'bookmarks/new'
    super(renderer: renderer, presenter: presenter)
  end
end