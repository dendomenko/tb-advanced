require_relative '../feature_helper'

feature 'Get updates of question to email', %q{
  In order to question updates
  As an authenticated user
  I want to be able to subscribe/unsubscribe to question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    given(:subscription) { create(:subscription, user: user, question: question) }

    background { sign_in user }

    scenario 'User subscribe for question' do
      visit question_path(question)
      find('.octicon-mail').click
      expect(page).to have_content 'Subscribed for question updates'
    end

    scenario 'User unsubscribe from question' do
      subscription
      visit question_path(question)
      find('.octicon-stop').click
      expect(page).to have_content 'Unsubscribed for question updates'
    end
  end

  describe 'Non-authenticated user' do
    scenario 'User does not see subscribe button' do
      visit question_path(question)
      expect(page).to_not have_css '.octicon-mail'
    end
  end
end
