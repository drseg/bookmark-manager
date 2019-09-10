feature 'Adding tags' do
  include_examples 'Test Helpers'

  feature 'A user can add and then view a tag' do
    scenario 'a comment is added to a bookmark' do
      apple = create_apple

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Tag'

      expect(current_path).to eq "/bookmarks/#{apple.id}/tags/new"

      fill_in 'tag', with: 'test tag'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'test tag'
    end
  end
end