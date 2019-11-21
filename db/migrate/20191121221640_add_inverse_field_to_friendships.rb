class AddInverseFieldToFriendships < ActiveRecord::Migration[5.2]
  def change
  	add_column :friendships, :inverse, :boolean, default: false
  end
end
