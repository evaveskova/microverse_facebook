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







# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'post' do
  let(:created_user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user) }
  let(:created_post) { FactoryBot.create(:post) }
  # let(:another_post) { FactoryBot.create(:post2) }

  def login(user)
    within 'form.form-inline' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end
  end

  def create_post(content)
    fill_in 'post[content]', with: content
    click_button 'create-post'
  end

  describe 'posts' do
    scenario 'current user can create post' do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      expect(page).to have_content(post_content)
    end

    scenario 'current user can edit his post' do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)
      click_link 'edit'
      fill_in 'post[content]', with: Faker::Lorem.paragraph
      click_button 'Edit'

      expect(page).not_to have_content(post_content)
    end

    scenario "current user can't edit another users post" do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)
      click_link 'edit'
      fill_in 'post[content]', with: Faker::Lorem.paragraph
      click_button 'Edit'
      expect(page).not_to have_content(post_content)

      click_link 'logout'
      visit root_path
      login(another_user)
      click_link 'edit'
      expect(page).to have_content('please you are not permited to edit this post')
    end

    scenario 'current user can delete his post' do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)
      click_link 'delete'

      expect(page).not_to have_content(post_content)
    end

    scenario "current user can't delete another users post" do
      visit root_path
      login(created_user)
      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      click_link 'logout'
      visit root_path
      login(another_user)
      click_link 'delete'
      expect(page).to have_content('please you are not permited to delete this post')
    end
  end
end
