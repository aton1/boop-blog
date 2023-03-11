# frozen_string_literal: true

namespace :seed do
  task :users => :environment do
    10.times do
      email = Faker::Internet.unique.email
      username = Faker::Internet.unique.username(specifier: 5..8)
      password = Faker::Internet.unique.password
      User.create!(email: email, username: username, password: password)
    end
  end
  task :categories => :environment do
    10.times do
      name = Faker::Beer.unique.brand
      Category.create!(name: name)
    end
  end
  task :articles => :environment do
    10.times do
      title = Faker::Hipster.unique.words
      description = Faker::Hipster.unique.sentence
      user= User.find(User.pluck(:id).sample)
      Article.create!(title: title, description: description, user: user)
    end
  end
end