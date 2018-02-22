require_relative '../feature_helper'

feature 'Rate answer', %q{
  In order to rate good or bad answer
  As an authenticated user
  I'd like to be rate answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User vote up answer', js: true do
    within "#answer_#{answer.id}" do
      expect(page).to have_link 'vote up'
      click_on 'vote up'
      within '#rating' do
        expect(page).to have_content '1'
      end
    end
  end

  scenario 'User vote down answer', js: true do
    within "#answer_#{answer.id}" do
      expect(page).to have_link 'vote down'
      click_on 'vote down'
      within '#rating' do
        expect(page).to have_content '-1'
      end
    end
  end
end
