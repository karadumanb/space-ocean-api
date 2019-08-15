class CustomerMailer < ApplicationMailer

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_notification_email(contact_form)
    @user_name = contact_form.name
    mail(
      :to => contact_form.email,
      :subject => 'Greetings from SpaceOcean.'
    )
  end
end
