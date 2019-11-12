class TableCreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :author_id,    foreign_key: true
      t.string :content

      t.timestamps
    end
    add_index :posts, :author_id
  end 
end
