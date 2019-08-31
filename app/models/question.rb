class Question < ApplicationRecord
    enum language_code: %i[tr, en]

    validates :body, presence: true, length: { minimum: 2, maximum: 20 }
    validates :answer, presence: true, length: { minimum: 2, maximum: 20 }
    validates :difficulty, :inclusion => 1..5

    def blank_stars
        5 - difficulty
    end
end
