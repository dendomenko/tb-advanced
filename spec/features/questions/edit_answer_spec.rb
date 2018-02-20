require_relative '../feature_helper'

feature 'Answer editing', %q(
  In order to fix mistake
  As an author
  I'd like to be able to edit answer
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  givem(:answer) { create(:answer, question: question) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  scenario 'Author try to edit his answer' do

  end

  scenario 'Authenticated user try yo edit other user\'s question' do

  end
end
