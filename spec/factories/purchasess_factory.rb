FactoryBot.define do
  factory :purchase do
    content factory: :movie
    user factory: :user
    expired { false }
    price {2.99}
    quality { 'sd' }
    available_until { 3.days.from_now }
  end
end