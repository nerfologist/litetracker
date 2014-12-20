FactoryGirl.define do
  factory :project do
    owner
    title { Faker::App.name }

    factory :project_with_tabs do
      after(:build) do |project|
        rand(1..4).times do
          project.tabs << build(:tab, project: project)
        end
      end
    end

    factory :project_full do
      after(:build) do |project|
        rand(1..4).times do
          project.tabs << build(:tab_with_stories, project: project)
        end
      end
    end
  end
end
