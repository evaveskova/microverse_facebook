class DropPosts < ActiveRecord::Migration[5.2]
  def change
  	drop_table :posts
  end
end
