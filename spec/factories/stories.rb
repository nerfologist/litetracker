FactoryGirl.define do
  factory :story do
    tab
    title { Faker::Lorem.sentence }
    sequence(:ord) { |n| n }
    state { %w(unstarted started finished accepted rejected).sample }
    maximized { [true, false].sample }
  end
end
