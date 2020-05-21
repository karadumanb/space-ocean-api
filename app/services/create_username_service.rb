class CreateUsernameService
  attr_accessor :email_first_part

  def initialize(email)
    @email_first_part = email.split('@').first.downcase
  end

  def call
    find_unique_username
  end

  private
  def find_unique_username
    taken_usernames = User.where("username LIKE ?", "#{email_first_part}%").pluck(:username)

    return email_first_part if ! taken_usernames.include?(email_first_part)

    count = 2
    while true
      new_username = "#{email_first_part}_#{count}"
      return new_username if !taken_usernames.include?(new_username)
      count += 1
    end
  end
end
