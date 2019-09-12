class SinatraView
  def initialize(renderer:, presenter:)
    @renderer = renderer
    @presenter = presenter
  end

  def show
    @renderer.call(@view, scope: @presenter)
  end
end