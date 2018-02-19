require 'rails_helper'

feature 'Look question and answers', %q{
  In order to get question
  As an user
  I want to be able to look on question with answers for this question
} do

  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }


  scenario 'User look on question' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content answer.answer
    expect(current_path).to eq question_path(question)
  end
end
