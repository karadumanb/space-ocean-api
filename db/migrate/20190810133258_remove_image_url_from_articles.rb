class RemoveImageUrlFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :image_url
  end
end
