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

  describe 'friending another user' do
    scenario 'current user can add friends' do
      visit root_path
      login(created_user)

      click_link 'users-index-link'

      expect(page).to have_content(created_user.first_name)
      click_button 'friend-link'
      expect(page).to have_content('has been added to your friend list')
    end

    scenario 'current user can unfriend another user' do
      visit root_path
      login(created_user)

      click_link 'users-index-link'

      expect(page).to have_content(created_user.first_name)
      click_button 'friend-link'
      expect(page).to have_content('has been added to your friend list')
      click_button 'unfriend-link'
      expect(page).to have_content('was successfully unfriended')
    end
  end
end
