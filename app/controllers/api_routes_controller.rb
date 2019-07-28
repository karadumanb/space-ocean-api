class ApiRoutesController < ApplicationController
    before_action :set_api_route, only: [:edit, :update, :show, :destroy]
    before_action :require_user

    def index
      @api_routes = ApiRoute.all
    end

    def new
      @api_route = ApiRoute.new
    end

    def edit
    end

    def create
      @api_route = ApiRoute.new(api_route_params)
      if @api_route.save
        flash[:success] = "Api Route was created successfully"
        redirect_to api_route_path(@api_route)
      else
        render 'new'
      end
    end

    def update
      if @api_route.update(api_route_params)
        flash[:success] = "Api Route was successfully updated"
        redirect_to api_route_path(@api_route)
      else
        render 'edit'
      end
    end

    def show
    end

    def destroy
      @api_route.destroy
      flash[:danger] = "Api Route was successfully deleted"
      redirect_to api_routes_path
    end

    private

    def set_api_route
      @api_route = ApiRoute.find(params[:id])
    end

    def api_route_params
      params.require(:api_route).permit(:route, :method, :response. :api_category_id)
    end
  end
