FactoryBot.define do
  factory :post do
    title { Faker::Lorem.paragraph }
    body { Faker::Lorem.sentence }
    user factory: :user
    tag_list { Faker::Lorem.word }
  end
end
