FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
  end
  factory :food do
    name { Faker::Lorem.sentence }
    measurement_unit { kg }
    price { 0 }
    association :user, factory: :user
  end
  factory :recipe do
    name { Faker::Lorem.sentence }
    preparation_time { 0 }
    cooking_time { 0 }
    description { Faker::Lorem.paragraph }
    association :user, factory: :user
  end
end
