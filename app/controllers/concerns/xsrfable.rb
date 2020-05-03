module Xsrfable
  extend ActiveSupport::Concern

  COOKIE_NAME = 'XSRF-TOKEN'.freeze

  included do
    after_action :set_xsrf_cookie
  end

  protected

  def set_xsrf_cookie
    return unless protect_against_forgery?

    cookies[COOKIE_NAME] = {
      value: form_authenticity_token,
      domain: request.domain
    }
  end
end
