class User < ApplicationRecord
  include Clearance::User
  ROLES = %w(super_admin developer designer entrepreneur member)

  has_many :articles, dependent: :destroy
  validates :username, uniqueness: { case_sensitive: false }, presence: true, length: {minimum: 3, maximum: 75}
  validates :email, uniqueness: { message: 'Email is already taken.' }, presence: true
  validates :password, presence: true, on: :create
  validates :password, presence: true, allow_blank: true, on: :update
  validate :valid_role?

  def User.create_by_email_with_password(email, password)
    User.where(email: email.downcase).first_or_create! do |u|
      u.password = password
      u.username = email.split('@').first
    end
  end

  def valid_role?
    if ROLES.exclude?(role) && role.present?
      errors.add(:role, "Users cannot be assigned roles other than #{ROLES.map{|e| e.humanize}.join(", ")}...")
    end
  end
end
