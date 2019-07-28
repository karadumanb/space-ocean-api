class ApiRoute < ApplicationRecord
    belongs_to :api_category
    validates :route, presence: true, length: { minimum: 3, maximum: 50 }
    validates :method, presence: true, length: { minimum: 3, maximum: 50 }
    validates :response, presence: true, length: { minimum: 8, maximum: 300 }
    validates :api_category_id, presence: true
end
