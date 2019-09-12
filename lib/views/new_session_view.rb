require_relative '../views/sinatra_view'

class NewSessionView < SinatraView
  def initialize(renderer:, presenter:)
    @view = :'sessions/new'
    super(renderer: renderer, presenter: presenter)
  end
end