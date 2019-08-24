class ApplicationController < ActionController::Base
	include MarkdownHelper
	#to make it available in views
	helper_method :current_user, :logged_in?
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end

	def require_user
		if !logged_in?
			flash[:error] = "You must be logged in to perform that action"
      		redirect_to login_path
		end
	end

	def require_admin
		if current_user.blank? || !current_user.admin?
			flash[:error] = "You must be admin to perform that action"
			redirect_to :back
		end
	end
end
