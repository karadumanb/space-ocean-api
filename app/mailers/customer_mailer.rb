class CustomerMailer < ApplicationMailer
  default :from => 'spaceocean.spacecraft@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_notification_email(contact_form)
    @user_name = contact_form.name
    mail(
      :to => contact_form.email,
      :title => "Greetings from SpaceOcean",
      :subject => 'Thanks for contacting us. We recevied your email and will be back to you soon.'
    )
  end
end
