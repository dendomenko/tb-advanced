require_relative '../feature_helper'

feature 'User sign in using facebook', %q(
  In order to be able to ask question
  As an user
  I want to be able to sign in using facebook
) do

  # given(:user) { create(:user) }\
  background do
    visit new_user_session_path
  end

  scenario 'User try to sign in using facebook' do
    click_on 'Sign in with Facebook'
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
    expect(current_path).to eq root_path
  end
end
