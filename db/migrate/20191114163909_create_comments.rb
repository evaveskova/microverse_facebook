class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :author, foreign_key: false
      t.references :post, foreign_key: false
      t.string :content

      t.timestamps
    end
  end
end
