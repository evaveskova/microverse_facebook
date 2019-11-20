class AddStatusFieldToFriendship < ActiveRecord::Migration[5.2]
  def change
  	add_column :friendships, :status, :boolean, default: false
  end
end
