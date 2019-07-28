class ApiRoute < ApplicationRecord
    belongs_to :api_category
    validates :api_category_id, presence: true
end
