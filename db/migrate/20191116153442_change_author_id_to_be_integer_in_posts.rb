class ChangeAuthorIdToBeIntegerInPosts < ActiveRecord::Migration[5.2]
  def change
  	change_column :posts, :author_id, 'integer USING CAST(author_id AS integer)'
  end

end
