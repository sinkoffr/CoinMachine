FactoryBot.define do
  factory :transaction do
    api_user { Faker:: Number.hexadecimal(digits: 32)}
    coin_id nil
  end
end