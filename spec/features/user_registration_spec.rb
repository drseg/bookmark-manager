feature 'Registering users' do
  let(:test_user)       { 'test user' }
  let(:test_password)   { 'test password' }

  scenario 'A user can register and see their name on the bookmarks screen' do
    visit '/users/new'
    fill_in('username', with: test_user)
    fill_in('password', with: test_password)
    click_button 'Submit'

    content = "Welcome, #{test_user}"
    expect(page).to have_content(content)
  end
end