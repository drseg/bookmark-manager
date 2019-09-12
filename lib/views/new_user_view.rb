require_relative '../views/sinatra_view'

class NewUserView < SinatraView
  def initialize(renderer:, presenter:)
    @view = :'users/new'
    super(renderer: renderer, presenter: presenter)
  end
end