APPLE_URL = 'http://www.apple.com'.freeze
GOOGLE_URL = 'http://www.google.com'.freeze

APPLE_TITLE = 'apple title'.freeze
GOOGLE_TITLE = 'google title'.freeze

shared_examples 'Test Helpers' do
  let(:apple)      { Bookmark.new(title: APPLE_TITLE, url: APPLE_URL) }
  let(:google)     { Bookmark.new(title: GOOGLE_TITLE, url: GOOGLE_URL) }

  def create_apple
    Bookmark.create(title: APPLE_TITLE, url: APPLE_URL)
  end

  def create_google
    Bookmark.create(title: GOOGLE_TITLE, url: GOOGLE_URL)
  end
end