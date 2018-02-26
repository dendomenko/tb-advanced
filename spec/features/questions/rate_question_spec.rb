require_relative '../feature_helper'

feature 'Rate question', %q{
  In order to rate good or bad question
  As an authenticated user
  I'd like to be rate question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    context 'add/remove new vote' do

      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'User vote up question', js: true do
        within '.voting' do
          click_on 'vote up'
          expect(page).to have_content '1'
        end
      end

      scenario 'User vote down question', js: true do
        within '.voting' do
          click_on 'vote down'
          expect(page).to have_content '-1'
        end
      end
    end

    context 'tries add vote for already voted question' do
      given!(:vote) { create(:vote, votable: question, user: user, rate: 1) }

      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'User vote up question', js: true do
        within '.voting' do
          click_on 'vote up'
          expect(page).to have_content 'You already have been voted!'
        end
      end
    end

    context 'tries add vote for his own question' do
      given(:my_question) { create(:question, user: user) }

      background do
        sign_in(user)
        visit question_path(my_question)
      end

      scenario 'User vote up question', js: true do
        within '.voting' do
          click_on 'vote up'
        end
        expect(page).to have_content 'Author can\'t vote!'
      end
    end
  end

  describe 'Non-authenticated user' do

    background do
      visit question_path(question)
    end

    scenario 'tries vote up question', js: true do
      within '.voting' do
        click_on 'vote up'
      end
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
