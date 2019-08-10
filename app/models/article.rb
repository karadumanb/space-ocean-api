class Article < ApplicationRecord
    belongs_to :user
    has_one_attached :image_url

    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 10, maximum: 800 }
    validates :user_id, presence: true
end
