FactoryBot.define do
  factory :coin do
    name { Faker::Lorem.word }
    value { 10 }
    count { 0 }
  end
end