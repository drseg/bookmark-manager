require_relative '../views/sinatra_view'

class UpdateBookmarkView < SinatraView
  def initialize(renderer:, presenter:)
    @view = :'bookmarks/edit'
    super(renderer: renderer, presenter: presenter)
  end
end