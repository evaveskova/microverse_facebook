# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts, id: false do |t|
      t.string :id,           null: false
      t.string :author_id,    foreign_key: true
      t.string :content

      t.timestamps
    end

    add_index :posts, :id, unique: true
  end
end
