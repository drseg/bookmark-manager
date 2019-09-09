feature 'Creating bookmarks' do
  let(:test_title) { 'test title' }
  let(:test_url)   { 'http://www.testbookmark.com' }

  scenario 'A user can add a new bookmark' do
    visit '/bookmarks/new'
    fill_in('title', with: test_title)
    fill_in('url', with: test_url)
    click_button 'Submit'

    expect(page).to have_link(test_title, href: test_url)
  end
end