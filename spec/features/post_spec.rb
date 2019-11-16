# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'post' do
  let(:created_user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user) }
  let(:created_post) { FactoryBot.create(:post) }
  # let(:another_post) { FactoryBot.create(:post2) }

  def new_user
    {
      first_name: Faker::Lorem.characters(number: 10),
      last_name: Faker::Lorem.characters(number: 10),
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      gender: %w[male female custom].sample,
      date: 18.years.ago
    }
  end

  def signup(new_user)
    within '.new_user' do
      fill_in 'user_first_name', with: new_user[:first_name]
      fill_in 'user_last_name', with: new_user[:last_name]
      fill_in 'user_email', with: new_user[:email]
      fill_in 'user_password', with: new_user[:password]
      select new_user[:date].day, from: 'user_birthday_3i'
      select Date::MONTHNAMES[new_user[:date].month], from: 'user_birthday_2i'
      select new_user[:date].year, from: 'user_birthday_1i'
      choose new_user[:gender]
      click_button 'Sign up'
    end
  end

  def login(user)
    within 'form.form-inline' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end
  end

  def raw_login(user)
    within 'form.form-inline' do
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      click_button 'Log in'
    end
  end

  def create_post(content)
    fill_in 'post[content]', with: content
    click_button 'create-post'
  end

  describe 'posts' do
    let(:roy) { new_user }
    let(:eva) { new_user }

    before do
      [roy, eva].each do |user|
        visit root_path
        signup(user)
        click_link 'logout'
      end
    end

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
      raw_login(roy)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)
      expect(page).to have_content(post_content)
      click_link 'logout'
      visit new_user_session_path
      raw_login(eva)
      visit root_path
      visit users_index_path
      click_button 'friend-link'
      expect(page).to have_content 'as been added to your friend list'
      visit root_path
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
      raw_login(roy)
      post_content = Faker::Lorem.paragraph
      create_post(post_content)
      expect(page).to have_content(post_content)
      click_link 'logout'
      visit new_user_session_path
      raw_login(eva)
      visit root_path
      visit users_index_path
      click_button 'friend-link'
      expect(page).to have_content 'as been added to your friend list'
      visit root_path
      click_link 'delete'
      expect(page).to have_content('please you are not permited to delete this post')
    end
  end
end
