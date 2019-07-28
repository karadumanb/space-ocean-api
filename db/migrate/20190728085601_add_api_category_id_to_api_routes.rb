class AddApiCategoryIdToApiRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :api_routes, :api_category_id, :integer
  end
end
