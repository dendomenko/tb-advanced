require_relative '../feature_helper'

feature 'Rate answer', %q{
  In order to rate good or bad answer
  As an authenticated user
  I'd like to be rate answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  describe 'Authenticated user' do
    context 'add/remove new vote' do

      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'vote up answer', js: true do
        within "#answer_#{answer.id}" do
          find('.oi-chevron-top').click
          expect(page).to have_content '1'
        end
      end

      scenario 'vote down answer', js: true do
        within "#answer_#{answer.id}" do
          find('.oi-chevron-bottom').click
          expect(page).to have_content '-1'
        end
      end
    end

    context 'tries add vote for already voted answer' do
      given!(:vote) { create(:vote, votable: answer, user: user, rate: 1) }

      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'tries vote up answer', js: true do
        within "#answer_#{answer.id}" do
          find('.oi-chevron-top').click
        end
        expect(page).to have_content 'you already have been voted!'
      end
    end

    context 'tries add vote for his own answer' do
      given!(:my_answer) { create(:answer, question: question, user: user) }

      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'vote up answer', js:true do
        within "#answer_#{my_answer.id}" do
          find('.oi-chevron-top').click
        end
        expect(page).to have_content 'Author can not vote for his own answer'
      end
    end
  end

  describe 'Non-authenticated user' do

    background do
      visit question_path(question)
    end

    scenario 'tries vote up answer', js:true do
      within "#answer_#{answer.id}" do
        find('.oi-chevron-top').click
      end
      expect(page).to have_content 'you need to sign in or sign up before continuing.'
    end
  end
end
