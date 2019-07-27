class ApplicationController < ActionController::Base
	#to make it available in views
	helper_method :current_user, :logged_in?, :convert_alert_class
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end

	def convert_alert_class(type = 'success')
		alert_types = {
			success: 'success',
			error: 'danger'
		}
		alert_types.as_json[type]
	end

	def require_user
		if !logged_in?
			flash[:error] = "You must be logged in to perform that action"
      		redirect_to login_path
		end
	end
end
