# frozen_string_literal: true

class ChangeBirthdayTypeFromUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :birthday, 'date USING CAST(birthday AS date)'
  end
end
