require './lib/user'


feature 'Authentication' do
  def create_test_user
    User.create(username: 'user', password: 'password')
  end

  def sign_in(username, password)
    visit '/sessions/new'
    fill_in(:username, with: username)
    fill_in(:password, with: password)
    click_button('Sign in')
  end

  feature 'Login' do
    scenario 'User logs in successfully' do
      create_test_user
      sign_in('user', 'password')

      expect(page).to have_content 'Welcome, user'
    end

    scenario 'User provides unknown username' do
      sign_in('user', 'password')

      expect(current_path).to eq '/sessions/new'
      expect(page).to have_content 'Please check your email or password.'
    end

    scenario 'User provides incorrect password' do
      create_test_user
      sign_in('user', 'nil')

      expect(current_path).to eq '/sessions/new'
      expect(page).to have_content 'Please check your email or password.'
    end
  end

  feature 'Logout' do
    scenario 'User logs out successfully' do
      create_test_user
      sign_in('user', 'password')
      click_button('Sign out')

      expect(page).not_to have_content 'Welcome, user'
      expect(page).to have_content 'You have signed out.'
    end
  end
end