class HomepageController < ApplicationController
    before_action :require_user

    API_ROUTES = [
        {
            title: "Blog",
            routes: [
                {
                    url: "/blogs",
                    method: "get"
                },
                {
                    url: "/blog/:id",
                    method: "post"
                }
            ]
        },
        {
            title: "Contact",
            routes: [
                {
                    url: "/contact-us",
                    method: "post"
                }
            ]
        }
    ]

    def index
        @routes = API_ROUTES
        # byebug
    end

end
