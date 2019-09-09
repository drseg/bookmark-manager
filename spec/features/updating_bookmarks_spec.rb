feature 'Updating bookmarks' do
  include_examples 'Test Helpers'

  scenario 'The user can edit an existing bookmark' do
    apple = create_apple
    visit '/bookmarks'
    expect(page).to have_link(apple_title, href: apple_url)

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{apple.id}/edit"

    fill_in('title', with: 'test')
    fill_in('url', with: 'test')
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link(apple_title, href: apple_url)
    expect(page).to have_link('test', href: 'test')
  end
end