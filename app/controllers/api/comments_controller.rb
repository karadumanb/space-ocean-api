class Api::CommentsController < Api::ApplicationController
    protect_from_forgery

    before_action :fetch_comments, only: [:index]

    def index
      render json: CommentSerializer.new(@comments, { params: serializer_params, include: includes }), status: :ok
    end

    def create
      @comment = Comment.new(comment_params)
      if @comment.save
        render json: CommentSerializer.new(@comment), status: :created
      else
        render json: serialize_errors(@comment), status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:user_name, :body, :article_id)
    end

    def filter_params
      return [] if params[:filter].blank?
      params[:filter].permit(article_ids: [])
    end

    def fetch_comments
      @comments = CommentQuery.new(Comment.all).filter_by(filter_params).order(sort_params)
    end
end
