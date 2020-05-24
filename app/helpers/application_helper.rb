module ApplicationHelper
  def full_domain
    if Rails.env.production?
      ENV['STAGING'] ? 'https://staging.spaceocean.co' : 'https://www.spaceocean.co'
    else
      'http://localhost:8000'
    end
  end

  def full_image_url(img)
    full_domain + '/images/' + img
  end
end
