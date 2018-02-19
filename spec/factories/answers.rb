FactoryBot.define do
  factory :answer do
    answer 'MyString'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    answer nil
    question nil
  end
end
