class Interactor
  def initialize(params:, session:, renderer:, redirect:, flash:)
    @params = params
    @session = session
    @renderer = renderer
    @redirect = redirect
    @flash = flash
  end

  def execute
    raise 'Interactor is abstract'
  end

  protected

  def flash
    @flash
  end

  def params
    @params
  end

  def session
    @session
  end

  def redirect(path)
    @redirect.call(path)
  end
end