class RegistrationService
  include Waterfall

  attr_accessor :email, :password, :user, :registration_params

  def initialize(params)
    @email = params[:email].downcase
    @password = params[:password]
    @registration_params = params

  end

  def call
    when_truthy { email_exist? }
      .dam { 'Email has already been taken' }
    when_falsy { valid_signup_data? }
      .dam { 'Please enter all required data' }
    chain { @user = create_user }
    chain { deliver_registration_email }
    chain (:user) { fetch_user }
  end

  private

  def email_exist?
    User.find_by(email: email).present?
  end

  def valid_signup_data?
    registration_params[:password].present? && registration_params[:email].present? && registration_params[:role].present?
  end

  def create_user
    User.create_by_email_with_password(email, password)
  end

  def deliver_registration_email
    UserMailer.registration(email).deliver
  end

  def fetch_user
    User.find(user.id)
  end
end
