# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    user { nil }
    friend { nil }
  end

  factory :like do
    likeable { nil }
    author { nil }
  end

  factory :comment do
    author { nil }
    post { nil }
    content { 'MyString' }
  end

  factory :post do
    content { Faker::Lorem.characters(number: 100) }
    association :author, factory: :user
  end

  factory :post2 do
    content { Faker::Lorem.characters(number: 180) }
    association :author, factory: :user2
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

  factory :user2 do
    first_name { Faker::Lorem.characters(number: 8) }
    last_name { Faker::Lorem.characters(number: 8) }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { Faker::Internet.password }
    gender { %w[male female custom].sample }
    birthday { 18.years.ago }
    image { 'http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802' }
  end
end
