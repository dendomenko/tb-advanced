require_relative '../feature_helper'

feature 'Create comment for question', %q{
  In order to add comment from community
  As an Authenticated uer
  I want to be able to add comments to questions
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context "mulitple sessions" do
    scenario "comment appears on another user's page", js: true do

      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        within '.new-question-comment' do
          click_on 'Comment'
          fill_in 'Text', with: 'Test comment'
          click_on 'Add Comment'
        end
        within '.question-comments' do
          expect(page).to have_content 'Test comment'
          expect(page).to have_content user.email
        end
      end

      Capybara.using_session('guest') do
        within '.question-comments' do
          expect(page).to have_content 'Test comment'
          expect(page).to have_content user.email
        end
      end
    end
  end
end
