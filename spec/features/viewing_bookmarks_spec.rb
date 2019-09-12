feature 'Viewing bookmarks' do
  include_examples 'Test Helpers'

  scenario 'visiting the index page' do
    visit '/'
    expect(current_path).to eq '/bookmarks'
  end

  scenario 'viewing bookmarks' do
    create_apple
    create_google

    visit '/bookmarks'

    apple = BookmarkRepository.all.first
    google = BookmarkRepository.all.last

    expect(page).to have_link(apple.title, href: apple.url)
    expect(page).to have_link(google.title, href: google.url)
  end
end