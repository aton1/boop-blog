FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 5..8) }
    password { Faker::Internet.password }

    factory :blogger do
      admin { false }
    end

    factory :admin do
      admin { true }
    end
  end
end
