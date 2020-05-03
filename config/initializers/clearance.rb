Clearance.configure do |config|
  config.httponly = true
  config.mailer_sender = 'spaceocean.spacecraft@gmail.com'
  config.rotate_csrf_on_sign_in = true
  config.routes = false
  config.sign_in_guards = [HasAccessGuard]
  config.cookie_name = "#{Rails.env}_remember_token"
  config.same_site = :none unless Rails.env.development? || Rails.env.test?
  config.secure_cookie = true unless Rails.env.development? || Rails.env.test?
end
