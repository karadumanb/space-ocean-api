class ApiCategory < ApplicationRecord
    has_many :api_routes

    scope :custom_display, -> { order(:created_at) }
end
