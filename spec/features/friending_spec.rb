# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'post' do
  let(:created_user) { FactoryBot.create(:user) }
  let(:created_post) { FactoryBot.create(:post) }
  let(:another_user) { FactoryBot.create(:user) }

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

  def create_post(content)
    fill_in 'post[content]', with: content
    click_button 'create-post'
  end

  def create_comment(content)
    fill_in 'comment[content]', with: content
    click_button 'comment-button'
  end

  def edit_comment(content)
    fill_in 'comment[content]', with: content
    click_button 'save-changes'
  end

  def create_like_on_post
    fill_in 'like[likeable_type]', with: 'Post'
    fill_in 'like[likeable_id]', with: 1
  end

  describe 'friendships' do
    let(:roy) { new_user }
    let(:eva) { new_user }

    # def raw_login(user)
    #   within 'form.form-inline' do
    #     fill_in 'user[email]', with: user[:email]
    #     fill_in 'user[password]', with: user[:password]
    #     click_button 'Log In'
    #   end
    # end

    def login(user)
      within 'form.form-inline' do
        fill_in 'user[email]', with: user[:email]
        fill_in 'user[password]', with: user[:password]
        click_button 'Log in'
      end
    end

    before do
      [roy, eva].each do |user|
        visit root_path
        signup(user)
        click_link 'logout'
      end
    end

    scenario 'user can add a friend' do
      visit root_path
      login(roy)
      visit users_index_path
      click_button 'friend-link'

      expect(page).to have_content 'as been added to your friend list'
    end

    scenario 'user can unfriend' do
      visit root_path
      login(roy)
      visit users_index_path
      click_button 'friend-link'
      expect(page).to have_content 'as been added to your friend list'
      click_button "unfriend-link"
      expect(page).to have_content "was successfully unfriended"
    end
  end
end
