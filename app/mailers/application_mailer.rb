class ApplicationMailer < ActionMailer::Base
  MAIL_ADDRESS = 'spaceocean.spacecraft@gmail.com'

  default to: -> { MAIL_ADDRESS },
  from: MAIL_ADDRESS
  layout 'mailer'
end
