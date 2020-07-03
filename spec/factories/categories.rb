FactoryBot.define do
  factory :category do
    name { Faker::Beer.brand }
  end
end
