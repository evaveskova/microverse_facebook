# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

FactoryBot.define do
  factory :post do
    content { Faker::Lorem.characters(number: 100) }
    association :author, factory: :user
  end

  factory :user do
    first_name { Faker::Lorem.characters(number: 10) }
    last_name { Faker::Lorem.characters(number: 10) }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { Faker::Internet.password }
    gender { %w[male female custom].sample }
    birthday { 18.years.ago }
    image { 'http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802' }
  end
end