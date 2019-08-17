class CustomerMailer < ApplicationMailer


  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_notification_email(contact_form)
    @contact_form = contact_form
    mail(
      :from => contact_form.email,
      :subject => contact_form.title
    )
  end
end
