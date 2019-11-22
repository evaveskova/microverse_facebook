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
  end
end
