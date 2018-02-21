FactoryBot.define do
  factory :answer do
    body 'MyString'
    question
    user
    best false
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question nil
  end
end
