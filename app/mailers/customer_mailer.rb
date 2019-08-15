class CustomerMailer < ApplicationMailer
  default :from => 'spaceocean.spacecraft@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_notification_email(email, name)
    @user_name = name
    mail( :to => email,
    :subject => 'Thanks for contacting us.' )
  end
end
