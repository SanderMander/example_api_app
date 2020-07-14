FactoryBot.define do
  factory :user do
    email { Faker::User.email }
  end
end