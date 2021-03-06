require_relative '../feature_helper'

feature 'Delete answer', %q{
  In order to delete my own answer
  As an Authenticated user
  I want to be able to delete my answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user delete answer', js: true do
    sign_in user
    visit question_path(question)
    within '.answers' do
      click_on 'Delete'

      expect(page).to_not have_content answer.body
      expect(current_path).to eq question_path(question)
    end
  end

  scenario 'Not authenticated user tries delete question' do
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
    expect(current_path).to eq question_path(question)
  end
end
