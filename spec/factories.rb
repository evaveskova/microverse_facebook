# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content {  }
    association :author, factory: :user
  end

  factory :user do
    first_name {  }
    last_name { }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { Faker::Internet.password }
    gender { %w[male female custom].sample }
    birthday { 18.years.ago }
    image { 'http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802' }
  end
end
