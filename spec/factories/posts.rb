FactoryBot.define do
  factory :post do
    post_status { 0 }
    title { Faker::Lorem.characters(number: 20) }
    body { Faker::Lorem.characters(number: 100) }
    user
  end
end
