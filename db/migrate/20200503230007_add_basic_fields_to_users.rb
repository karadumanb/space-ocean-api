class AddBasicFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :admin
    add_column :users, :role, :string
    add_column :users, :email, :string, unique: true
    add_column :users, :locale, :string
    add_column :users, :photo_id, :integer
    add_column :users, :archived, :boolean, default: false
    add_column :users, :website_cv, :string
    add_column :users, :website, :string
    add_column :users, :facebook, :string
    add_column :users, :linked_in, :string
    add_column :users, :twitter, :string
    add_column :users, :instagram, :string
  end
end
