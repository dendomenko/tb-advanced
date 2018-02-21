# frozen_string_literal: true

require_relative '../feature_helper'

feature 'Answer editing', "
  In order to fix mistake
  As an author
  I'd like to be able to edit answer
" do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given(:new_user) { create(:user) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    context 'as author' do
      before do
        sign_in user
        visit question_path(question)
      end

      scenario 'see edit link' do
        within '.answers' do
          expect(page).to have_link 'Edit'
        end
      end

      scenario 'try to edit his answer', js: true do
        click_on 'Edit'
        within '.answers' do
          fill_in 'Answer', with: 'edited answer'
          click_on 'Save'
          expect(page).to_not have_content answer.answer
          expect(page).to have_content 'edited answer'
          expect(page).to_not have_selector 'textarea'
        end
      end
    end

    scenario 'try to edit other user\'s question' do
      sign_in new_user
      visit question_path(question)

      expect(page).to_not have_link 'Edit'
    end
  end
end
