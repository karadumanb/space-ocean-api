# frozen_string_literal: true

# Controller for articles
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    attach_image
    if @article.save
      flash[:success] = 'Article was created successfully'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    attach_image
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was successfully deleted'
    redirect_to articles_path
  end

  def markdown_result
    @description = params[:description]
    respond_to do |format|
      format.html { render(:partial => 'articles/markdown_result', :locals => {:description => @description}) }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :image_url, :description, category_ids: [])
  end

  def attach_image
    return if article_params[:image_url].present?

    @article.image_url.attach(article_params[:image_url])
  end

  def require_same_user
    return if current_user != @article.user && !current_user.admin?

    flash[:danger] = 'You can only edit or delete your own article'
    redirect_to root_path
  end
end
