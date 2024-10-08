FactoryBot.define do
  factory :comment do
    body { "This is my super awesome comment" }
    parent { nil }
    user
    project
  end
end
