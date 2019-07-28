class ApiCategory < ApplicationRecord
    has_many :api_routes
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 3, maximum: 150 }
    scope :custom_display, -> { order(:created_at).last(4) }
end
