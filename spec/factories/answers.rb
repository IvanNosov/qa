FactoryBot.define do
  factory :answer, class: 'Answer' do
    body 'MyString'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question nil
  end
end
