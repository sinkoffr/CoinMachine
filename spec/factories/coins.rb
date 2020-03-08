FactoryBot.define do
  factory :coin do
    name { Faker::Lorem.word }
    value { 10 }
  end
end