require_relative '../views/sinatra_view'

class NewCommentView < SinatraView
  def initialize(renderer:, presenter:)
    @view = :'comments/new'
    super(renderer: renderer, presenter: presenter)
  end
end