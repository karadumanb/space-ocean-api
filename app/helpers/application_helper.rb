module ApplicationHelper
    def full_domain
        if Rails.env.production?
            ENV['STAGING'] ? 'https://staging.space-ocean.com' : 'https://www.space-ocean.com'
        else
            'http://localhost:3000'
        end
    end

    def full_image_url(img)
        full_domain + '/images/' + img
    end

	def convert_alert_class(type = 'success')
		alert_types = {
			success: 'success',
			error: 'danger'
        }
		alert_types.as_json[type].blank? ? type : alert_types.as_json[type]
	end
end
