require_relative '../feature_helper'

feature 'Remove file from answer or question', %q{
  In order to delete wrong file
  As an content author
  I'd like to be able to remove file
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question, user: user, attachments: create_list(:attachment, 1))}

  background do
    sign_in(user)
    visit question_path(question)
  end

  context 'Author' do
    scenario 'sees remove file link' do
      within '.question-attachments' do
        expect(page).to have_link 'Remove file'
      end
    end

    scenario 'remove file from question' do

      within '.question-attachments' do
        click_on 'Remove file'
      end
      expect(page).to_not have_link 'Remove file'
    end
  end
end