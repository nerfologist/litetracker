require 'faker'

FactoryGirl.define do
  factory :user, aliases: [:owner] do |u|
    u.email { Faker::Internet.email }
    u.password { Faker::Internet.password(6) }
  end
end
