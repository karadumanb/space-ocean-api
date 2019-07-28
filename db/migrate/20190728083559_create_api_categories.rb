class CreateApiCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :api_categories do |t|
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
