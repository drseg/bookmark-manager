feature 'Viewing bookmarks' do
  include_examples 'Test Helpers'

  scenario 'visiting the index page' do
    visit '/'
    expect(page).to have_content 'Bookmark Manager'
  end

  scenario 'viewing bookmarks' do
    create_apple
    create_google

    visit '/bookmarks'

    apple = Bookmark.all.first
    google = Bookmark.all.last

    expect(page).to have_link(apple.title, href: apple.url)
    expect(page).to have_link(google.title, href: google.url)
  end
end