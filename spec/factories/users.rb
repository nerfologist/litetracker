FactoryGirl.define do
  factory :user, aliases: [:owner] do
    email { Faker::Internet.email }
    password { Faker::Internet.password(6) }

    factory :user_no_email do
      email nil
    end

    factory :user_no_password do
      password nil
    end
  end
end
