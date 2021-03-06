require_relative '../feature_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an Authenticated uer
  I want to be able to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in user

    visit questions_path
    click_on 'Ask a question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'test test'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Not authenticated user tries creates question' do
    visit questions_path
    click_on 'Ask a question'

    expect(page).to have_content 'You need to sign in or sign up'
  end

  context "mulitple sessions" do
    scenario "question appears on another user's page", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path
      end

      Capybara.using_session('guest') do
        visit questions_path
      end

      Capybara.using_session('user') do
        click_on 'Ask a question'
        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'test text'
        click_on 'Create'
        expect(page).to have_content 'Test question'
        expect(page).to have_content 'test text'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Test question'
      end
    end
  end
end
