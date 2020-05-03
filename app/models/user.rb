class User < ApplicationRecord
  include Clearance::User

  has_many :articles, dependent: :destroy
  validates :username, uniqueness: { case_sensitive: false }, presence: true, length: {minimum: 3, maximum: 15}
  has_secure_password
end
