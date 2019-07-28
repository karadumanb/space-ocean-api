class HomepageController < ApplicationController
    before_action :require_user

    def index
        @api_categories = ApiCategory.custom_display
        # byebug
    end

end
