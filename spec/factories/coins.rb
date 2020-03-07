FactoryBot.define do
  factory :coin do
    name { Faker::Lorem.word }
    value { Faker:: Number.number(10) }
  end
end