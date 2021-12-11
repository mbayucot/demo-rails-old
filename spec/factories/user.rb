FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    stripe_customer_id { Faker::Alphanumeric.alpha(number: 10) }

    trait :with_confirmed do
      after(:create, &:skip_confirmation!)
    end

    trait :with_subscription do
      after(:create) do |user|
        create(:subscription, user_id: user.id)
      end
    end
  end
end
