# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'post' do
  let(:created_user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user) }
  let(:created_post) { FactoryBot.create(:post) }
  #let(:another_post) { FactoryBot.create(:post2) }

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
      click_link "edit"
      expect(page).to have_content("please you are not permited to edit this post")
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

      click_link "logout"
      visit root_path
      login(another_user)
      click_link 'delete'
      expect(page).to have_content("please you are not permited to delete this post")
    end
  end
end
