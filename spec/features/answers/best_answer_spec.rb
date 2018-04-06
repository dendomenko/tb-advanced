require_relative '../feature_helper'

feature 'Make answer as the best answer for question', %q{
  In order to show right answer
  As an Authenticated user
  I want to be able to make answer as the best answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question) }
  given(:best_answer) { create(:answer, question: question, best: true) }
  given(:another_user) { create(:user) }

  describe 'Authetticated user' do
    context 'as author' do
      before do
        sign_in user
      end

      context 'one answer' do
        before do
          visit question_path(question)
        end
        scenario 'sees best link', js: true do
          within '.answers' do
            expect(page).to have_link 'Best Answer'
          end
        end

        scenario ' choose best answer', js: true do
          within '.answers' do
            click_on 'Best Answer'
            expect(page).to have_css 'div.row.text-left.border-bottom.has-best'
          end
          expect(current_path).to eq question_path(question)
        end
      end

      scenario ' change best answer', js: true do
        best_answer
        visit question_path(question)

        within "#answer_#{answer.id}" do
          click_on 'Best Answer'
        end
        expect(page).to have_css 'div.row.text-left.border-bottom.has-best'

        expect(current_path).to eq question_path(question)
      end
    end

    scenario 'tries choose best answer for another user question', js: true do
      sign_in another_user
      visit question_path(question)
      expect(page).to_not have_link 'Best Answer'
    end
  end

  scenario 'Not authenticated user tries choose best answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Best Answer'
  end
end