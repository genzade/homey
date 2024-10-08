FactoryBot.define do
  factory :project do
    name { "My Awesome Project Name" }
    status { :ignition }

    after(:create) do |project|
      create_list(:user, 2, projects: [ project ])
    end
  end
end
