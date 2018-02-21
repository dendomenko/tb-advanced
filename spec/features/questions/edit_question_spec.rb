# frozen_string_literal: true

require_relative '../feature_helper'

feature 'Question editing', "
  In order to fix mistake
  As an author
  I'd like to be able to edit question
" do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:new_user) { create(:user) }

  scenario 'Unauthenticated user try to edit question' do
    visit questions_path

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    context 'as author' do
      before do
        sign_in user
        visit questions_path
      end

      scenario 'see edit link' do
        within '.questions' do
          expect(page).to have_link 'Edit'
        end
      end

      scenario 'try to edit his question', js: true do
        click_on 'Edit'
        within '.questions' do
          fill_in 'Title', with: 'edited question title'
          fill_in 'Body', with: 'edited question body'
          click_on 'Save'
          expect(page).to_not have_content question.title
          expect(page).to_not have_content question.body
          expect(page).to have_content 'edited question title'
          expect(page).to have_content 'edited question body'
          expect(page).to_not have_selector 'textarea'
          expect(page).to_not have_selector 'textarea'
        end
      end
    end

    scenario 'try to edit other user\'s question' do
      sign_in new_user
      visit questions_path

      expect(page).to_not have_link 'Edit'
    end
  end
end
