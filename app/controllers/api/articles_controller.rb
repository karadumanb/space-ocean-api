class Api::ArticlesController < Api::ApplicationController
  before_action :fetch_articles, only: [:index]
  before_action :set_article, only: %i[show update]

  def index
    render json: Article::BaseSerializer.new(@articles, {params: serializer_params, include: includes, meta: pagination_meta(@articles)}), status: :ok
  end

  def show
    if @article
      render json: Article::DefaultSerializer.new(@article, {params: serializer_params, include: includes}), status: :ok
    else
      render json: serialize_errors(@article), status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      render json: Article::DefaultSerializer.new(@article, {params: serializer_params, include: includes}), status: :ok
    else
      render json: serialize_errors(@article), status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def filter_params
    return [] if params[:filter].blank?

    params[:filter].permit(project_ids: [])
  end

  def fetch_articles
    @articles = ArticleQuery.new(Article.all).filter_by(filter_params).order(sort_params).page(page_param).per_page(per_page_param)
  end
end

