
shared_examples 'Test Helpers' do
  let(:apple_url)    { 'http://www.apple.com' }
  let(:google_url)   { 'http://www.google.com' }

  let(:apple_title)  { 'apple title' }
  let(:google_title) { 'google title' }

  def create_apple
    Bookmark.create(title: apple_title, url: apple_url)
  end

  def create_google
    Bookmark.create(title: google_title, url: google_url)
  end
end