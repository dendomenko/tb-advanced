require_relative '../feature_helper'

feature 'Rate question', %q{
  In order to rate good or bad question
  As an authenticated user
  I'd like to be rate question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User vote up question', js: true do
    within '.voting' do
      # expect(page).to have_content 'vote up'
      click_on 'vote up'
      expect(page).to have_content '1'
    end
  end

  scenario 'User vote down question', js: true do
    within '.voting' do
      # expect(page).to have_content 'vote down'
      click_on 'vote down'
      expect(page).to have_content '-1'
    end
  end
end
