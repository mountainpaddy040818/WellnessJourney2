FactoryBot.define do
  factory :health_record do
    exercise { Faker::Lorem.characters(number:50) }
    training_content { Faker::Lorem.characters(number:50) }
    diet_content { Faker::Lorem.characters(number:50) }
    today_impression { Faker::Lorem.characters(number:100) }
    tag_name { Faker::Lorem.characters(number:20) }
  end
end