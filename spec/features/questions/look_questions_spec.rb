require 'rails_helper'

feature 'Look questions', %q{
  In order to get all questions
  As an user
  I want to be able to look on questions list
} do

  scenario 'User look on questions' do    
    visit questions_path
    
    expect(page).to have_content 'All Questions'
    expect(current_path).to eq questions_path    
  end
end