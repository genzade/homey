FactoryBot.define do
  factory :history do
    trackable { nil }
    user
    action { :created }
    tracked_field { "MyString" }
    tracked_value { "MyString" }
  end
end
