require_relative '../feature_helper'

feature 'Create comment for answer', %q{
  In order to add comment from community
  As an Authenticated uer
  I want to be able to add comments to answers
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

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
        within "#answer_#{answer.id}" do
          click_on 'Comment'
          fill_in 'Text', with: 'test comment'
          click_on 'Add Comment'
        end
        within ".answer-comments-#{answer.id}" do
          expect(page).to have_content 'test comment'
          expect(page).to have_content user.email
        end
      end

      Capybara.using_session('guest') do
        within ".answer-comments-#{answer.id}" do
          expect(page).to have_content 'test comment'
          expect(page).to have_content user.email
        end
      end
    end
  end
end
