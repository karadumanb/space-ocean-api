# Be sure to restart your server when you modify this file.

if Rails.env.production?
    Rails.application.config.session_store :cookie_store, key: '_webapp_session', domain: %w(www.spaceocean.co)
  else
    Rails.application.config.session_store :cookie_store, key: '_webapp_session', domain: :all
end
