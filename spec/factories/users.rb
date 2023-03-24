FactoryBot.define do
  factory :user do
    first_name { Faker::Lorem.characters(number: 10) }
    last_name { Faker::Lorem.characters(number: 10) }
    first_name_kana { Faker::Lorem.characters(number: 10) }
    last_name_kana { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }

    after(:build) do |user|
      user.image.attach(io: File.open("spec/images/no_image.png"), filename: "no_image.png", content_type: "application/xlsx")
    end
  end
end
