class ApiCategoriesController < ApplicationController
  before_action :set_api_category, only: [:edit, :update, :show, :destroy]
  before_action :require_user

  def index
    @api_categories = ApiCategory.paginate(page: params[:page], per_page: 5)
  end

  def new
    @api_category = ApiCategory.new
  end

  def edit
  end

  def create
    @api_category = ApiCategory.new(api_category_params)
    if @api_category.save
      flash[:success] = "Api Category was created successfully"
      redirect_to api_category_path(@api_category)
    else
      render 'new'
    end
  end

  def update
    if @api_category.update(api_category_params)
      flash[:success] = "Api Category was successfully updated"
      redirect_to api_category_path(@api_category)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @api_category.destroy
    flash[:danger] = "Api Category was successfully deleted"
    redirect_to api_categories_path
  end

  private

  def set_api_category
    @api_category = ApiCategory.find(params[:id])
  end

  def api_category_params
    params.require(:api_category).permit(:title, :description)
  end
end
