class ContactForm < ApplicationRecord
    validates :title, presence: true, length: { minimum: 3, maximum: 60 }
    validates :body, presence: true, length: { minimum: 10, maximum: 800 }
    validates :email, presence: true, length: { minimum: 3, maximum: 60 }
    validates_format_of :email, with: Validate::REGEX_EMAIL, message: 'Please provide correct email', allow_blank: true
    validates :name, presence: true, length: { minimum: 3, maximum: 60 }
end
