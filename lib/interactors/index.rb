require_relative './interactor'

class Index < Interactor
  def execute
    redirect '/bookmarks'
  end
end