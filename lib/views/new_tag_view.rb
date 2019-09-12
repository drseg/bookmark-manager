require_relative '../views/sinatra_view'

class NewTagView < SinatraView
  def initialize(renderer:, presenter:)
    @view = :'tags/new'
    super(renderer: renderer, presenter: presenter)
  end
end