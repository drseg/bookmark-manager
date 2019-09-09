feature 'Viewing bookmarks' do
  scenario 'visiting the index page' do
    visit '/'
    expect(page).to have_content 'Bookmark Manager'
  end

  scenario 'viewing bookmarks' do
    visit '/bookmarks'
    expect(page).to have_content Bookmark.all.first
    expect(page).to have_content Bookmark.all.last
  end
end