# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  let(:created_user) { FactoryBot.create(:user) }

  def new_user
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
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

  describe 'user signup login logout' do
    scenario 'can create account' do
      visit root_path
      signup(new_user)

      expect(page).to have_content('successfully.')
    end

    scenario 'user can login' do
      visit root_path
      login(created_user)

      expect(page).to have_content(created_user.first_name)
    end

    scenario 'user can log out' do
      visit root_path
      login(created_user)

      click_link 'logout'

      expect(page).not_to have_content(created_user.first_name)
    end
  end
end
