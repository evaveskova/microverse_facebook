# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'post' do
  let(:created_user) { FactoryBot.create(:user) }
  let(:created_post) { FactoryBot.create(:post) }
  let(:another_user) { FactoryBot.create(:user) }

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

  describe 'comments and likes' do
    let(:roy) { new_user }
    let(:eva) { new_user }

    before do
      [roy, eva].each do |user|
        visit root_path
        signup(user)
        click_link 'logout'
      end
    end

    scenario 'current user can comment on post' do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      expect(page).to have_content(post_content)

      comment_content = Faker::Lorem.paragraph
      create_comment(comment_content)
      expect(page).to have_content(comment_content)
    end

    scenario 'current user can delete his comment' do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      expect(page).to have_content(post_content)

      comment_content = Faker::Lorem.paragraph
      create_comment(comment_content)
      expect(page).to have_content(comment_content)
      click_link 'delete-comment'
      expect(page).not_to have_content(comment_content)
    end

    scenario "current user can't delete another users comment" do
      visit root_path
      raw_login(roy)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      comment_content = Faker::Lorem.paragraph
      create_comment(comment_content)
      expect(page).to have_content(comment_content)
      click_link 'logout'
      visit new_user_session_path
      raw_login(eva)
      visit root_path
      visit users_index_path
      click_button 'friend-link'
      expect(page).to have_content 'as been added to your friend list'
      visit root_path
      click_link 'delete-comment'
      expect(page).to have_content('please you are not permited to delete this comment')
    end

    scenario 'current user can edit his comment' do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      expect(page).to have_content(post_content)

      comment_content = Faker::Lorem.paragraph
      create_comment(comment_content)
      expect(page).to have_content(comment_content)
      click_link 'edit-comment'

      edit_content = Faker::Lorem.paragraph
      edit_comment(edit_content)
      expect(page).not_to have_content(comment_content)
    end

    scenario "current user can't edit another users comment" do
      visit root_path
      raw_login(roy)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      comment_content = Faker::Lorem.paragraph
      create_comment(comment_content)
      expect(page).to have_content(comment_content)
      click_link 'logout'
      visit new_user_session_path
      raw_login(eva)
      visit root_path
      visit users_index_path
      click_button 'friend-link'
      expect(page).to have_content 'as been added to your friend list'
      visit root_path
      click_link 'edit-comment'
      expect(page).to have_content('please you are not permited to edit this comment')
    end

    scenario 'current user can like a post' do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      expect(page).to have_content(post_content)

      click_button 'like-post'
      expect(page).to have_content('liked a Post')
    end

    scenario "current user can't like a post two times" do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)

      expect(page).to have_content(post_content)

      click_button 'like-post'
      expect(page).to have_content('liked a Post')
      click_button 'like-post'
      expect(page).not_to have_content('liked a Post')
    end

    scenario 'current user can like a comment' do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)
      expect(page).to have_content(post_content)

      comment_content = Faker::Lorem.paragraph
      create_comment(comment_content)
      expect(page).to have_content(comment_content)

      click_button 'like-comment'
      expect(page).to have_content('liked a Comment')
    end

    scenario "current user can't like a comment two times" do
      visit root_path
      login(created_user)

      post_content = Faker::Lorem.paragraph
      create_post(post_content)
      expect(page).to have_content(post_content)

      comment_content = Faker::Lorem.paragraph
      create_comment(comment_content)
      expect(page).to have_content(comment_content)

      click_button 'like-comment'
      expect(page).to have_content('liked a Comment')
      click_button 'like-comment'
      expect(page).not_to have_content('liked a Comment')
    end
  end
end
