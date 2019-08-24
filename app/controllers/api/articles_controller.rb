class Api::ArticlesController < Api::ApplicationController
  before_action :fetch_articles, only: [:index]
  before_action :set_article, only: [:show]

  def index
    render json: ArticleBasicSerializer.new(@articles, { params: serializer_params, include: includes }), status: :ok
  end

  def show
    if @article
      render json: ArticleSerializer.new(@article, { params: serializer_params, include: includes }), status: :ok
    else
      render json: serialize_errors(@article), status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def filter_params
    return [] if params[:filter].blank?
    params[:filter].permit(project_ids: [])
  end

  def fetch_articles
    @articles = ArticleQuery.new(Article.all).filter_by(filter_params).order(sort_params)
  end
end

