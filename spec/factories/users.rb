FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@mail.com" }
    password { "MyPassword" }
  end
end
