class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :user_name
      t.text :body
      t.integer :article_id
      t.timestamps
    end
  end
end
