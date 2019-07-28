class CreateApiRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :api_routes do |t|
      t.string :route
      t.string :method
      t.string :response
      t.timestamps
    end
  end
end
