FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "876asdf"
    password_confirmation "876asdf"

    factory :admin do
      admin true
    end
  end

  factory :bank do
    name "Security Test Bank"
    user_id 1
  end

  factory :envelope do
    category 'car'
    total    20
    bank_id 1
  end
end
