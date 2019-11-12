# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(first_name: 'firstname',
                     last_name: 'lastname',
                     email: 'user1@example.com',
                     password: 'password',
                     gender: 'male',
                     birthday: '2019-11-06')
  end

  context 'Valid user' do
    it 'user should be valid' do
      expect(@user).to be_valid
    end

    it 'first name should be present' do
      @user.first_name = '     '
      expect(@user).not_to be_valid
    end

    it 'last name should be present' do
      @user.last_name = '     '
      expect(@user).not_to be_valid
    end

    it 'email should be present' do
      @user.email = '     '
      expect(@user).not_to be_valid
    end

    it 'date of birth should be present' do
      @user.birthday = '     '
      expect(@user).not_to be_valid
    end

    it 'gender should be present' do
      @user.gender = '     '
      expect(@user).not_to be_valid
    end

    it 'first name should not be too long' do
      @user.first_name = 'a' * 51
      expect(@user).not_to be_valid
    end

    it 'last name should not be too long' do
      @user.last_name = 'a' * 51
      expect(@user).not_to be_valid
    end

    it 'password should be present' do
      @user.password = '     '
      expect(@user).not_to be_valid
    end
  end

  context 'email validation' do
    it 'email validation should accept valid addresses' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid "#{valid_address.inspect} should be valid"
      end
    end

    it 'email addresses should be unique' do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).not_to be_valid
    end
  end
end
