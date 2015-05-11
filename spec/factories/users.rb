FactoryGirl.define do
  factory :user, aliases: [:owner] do
    email { Faker::Internet.email }
    password { Faker::Internet.password(6) }

    factory :user_no_email do
      email nil
    end

    factory :user_blank_password do
      password ''
    end

    factory :demo_user do
      email 'demo@users.com'
      password 'demodemo'
    end
  end
end
