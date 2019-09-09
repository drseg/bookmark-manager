feature 'Viewing bookmarks' do
  scenario 'visiting the index page' do
    visit '/'
    expect(page).to have_content 'Bookmark Manager'
  end

  scenario 'viewing bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.apple.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

    visit '/bookmarks'
    expect(page).to have_content Bookmark.all.first
    expect(page).to have_content Bookmark.all.last
  end
end