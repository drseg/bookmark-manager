feature 'Deleting bookmarks' do
  include_examples 'Test Helpers'

  scenario 'The user can delete a bookmark' do
    create_apple
    visit '/bookmarks'
    expect(page).to have_link(apple_title, href: apple_url)

    first('.bookmark').click_button 'Delete'
    visit '/bookmarks'
    expect(page).not_to have_link(apple_title, href: apple_url)
  end
end