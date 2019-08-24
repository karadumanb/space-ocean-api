class Comment < ApplicationRecord
    belongs_to :article

    validates :user_name, presence: true, length: { minimum: 3, maximum: 50 }
    validates :body, presence: true, length: { minimum: 5, maximum: 1000 }
end
