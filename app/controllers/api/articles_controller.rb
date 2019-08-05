class Api::ArticlesController < Api::ApplicationController
  before_action :fetch_articles, only: [:index]
  before_action :set_article, only: [:destroy, :update]

  def index
    render json: ArticleSerializer.new(@articles, { params: serializer_params, include: includes }), status: :ok
  end

  def create
    @articles = Article.new(article_params)
    if @articles.save
      render json: ArticleSerializer.new(@articles), status: :created
    else
      render json: serialize_errors(@articles), status: :unprocessable_entity
    end
  end

  def update
    if @articles.update(article_params)
      render json: ArticleSerializer.new(@articles), status: :ok
    else
      render json: serialize_errors(@articles), status: :unprocessable_entity
    end
  end

  def destroy
    if @articles.destroy
      head :no_content
    else
      render json: serialize_errors(@articles), status: :unprocessable_entity
    end
  end

  private

  def set_article
    @articles = Article.find(params[:id])
  end

  def filter_params
    return [] if params[:filter].blank?
    params[:filter].permit(project_ids: [])
  end

  def fetch_articles
    @articles = ArticleQuery.new(Article.all).filter_by(filter_params).order(sort_params)
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end

