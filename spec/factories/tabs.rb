FactoryGirl.define do
  factory :tab do
    project
    name { Faker::Hacker.noun }
    sequence(:ord) { |n| n }

    factory :tab_with_stories do
      after(:build) do |tab|
        rand(1..6).times do
          tab.stories << build(:story, tab: tab)
        end
      end
    end
  end
end
