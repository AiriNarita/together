FactoryBot.define do
  factory :event do
    event_name { Faker::Lorem.characters(number: 20) }
    event_introduction { Faker::Lorem.characters(number: 100) }

    # creator という Trait で利用するため、ここでは定義しない
    # creator
    trait :with_creator do
      # user を利用するために factory :user を定義し、let(:user) { create(:user) } で呼び出す
      association :creator, factory: :user
    end
  end
end
