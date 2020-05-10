class User < ApplicationRecord
  include Clearance::User

  has_many :articles, dependent: :destroy
  validates :username, uniqueness: { case_sensitive: false }, presence: true, length: {minimum: 3, maximum: 15}
  validates :email, uniqueness: { message: 'Email is already taken.' }, presence: true
  validates :password, presence: true, on: :create
  validates :password, presence: true, allow_blank: true, on: :update
end
