feature 'Adding and viewing comments' do
  include_examples 'Test Helpers'

  feature 'a user can add and then view a comment' do
    scenario 'a comment is added to a bookmark' do
      apple = create_apple

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Comment'

      expect(current_path).to eq "/bookmarks/#{apple.id}/comments/new"
      fill_in 'comment', with: 'This is a comment'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'This is a comment'
    end
  end
end