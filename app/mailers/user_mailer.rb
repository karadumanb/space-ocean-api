class UserMailer < ApplicationMailer


  # send a signup email to the user, pass in the user object that   contains the user's email address
  def registration(email)
    @user = User.find_by(email: email)
    mail(
      :to => email,
      :subject => 'YOU ARE WITH US!'
    )
  end
end
