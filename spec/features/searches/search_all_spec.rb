require_relative '../feature_helper'

feature 'Search data', %q{
  In order to find phrase
  As an user
  I want to be able to search data
} do

  given!(:question) { create(:question, title: 'Test question') }
  given!(:answer) { create(:answer, body: 'test answer') }
  given!(:comment) { create(:comment, text: 'Test comment', commentable: question) }
  given!(:user) { create(:user, email: 'test@user.com') }


  describe "Searching for All" do
    it 'search all', js: true do
      Question.reindex
      Answer.reindex
      Comment.reindex
      User.reindex
      visit questions_path
      fill_in "query", with: 'Test'
      click_on 'Search'

      within '.results' do
        expect(page).to have_content('Test question')
        click_on 'Answers'
        expect(page).to have_content('test answer')
        click_on 'Comments'
        expect(page).to have_content('Test comment')
        click_on 'Users'
        expect(page).to have_content('test@user.com')
      end
    end
  end
end