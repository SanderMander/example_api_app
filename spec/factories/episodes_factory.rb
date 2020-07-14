FactoryBot.define do
  factory :episode do
    title { Faker::Lorem.word }
    plot { Faker::Lorem.paragraph }
    number { Faker::Number.digit }
    season factory: :season
  end
end