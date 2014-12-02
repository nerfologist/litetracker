FactoryGirl.define do
  factory :project do
    owner
    title { Faker::App.name }
  end
end
