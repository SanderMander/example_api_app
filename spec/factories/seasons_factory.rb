FactoryBot.define do
  factory :season do
    title { Faker::Lorem.word }
    plot { Faker::Lorem.paragraph }
    number { Faker::Number.digit }
  end
end