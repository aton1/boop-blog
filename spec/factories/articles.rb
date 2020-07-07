FactoryBot.define do
  factory :article do
    title { Faker::Hipster.words }
    description { Faker::Hipster.sentence }
    user { create(:user) }
  end
end
