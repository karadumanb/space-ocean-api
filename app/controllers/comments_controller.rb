class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :show, :destroy]
    before_action :require_admin, only: [:edit, :update, :destroy]

    def index
      @comments = Comment.paginate(page: params[:page], per_page: 5)
    end

    def new
      @comment = Comment.new
    end

    def edit
    end

    def create
      @comment = Comment.new(comment_params)
      if @comment.save
        flash[:success] = "Comment was created successfully"
        redirect_to comment_path(@comment)
      else
        render 'new'
      end
    end

    def update
      if @comment.update(comment_params)
        flash[:success] = "Comment was successfully updated"
        redirect_to comment_path(@comment)
      else
        render 'edit'
      end
    end

    def show
    end

    def destroy
      @comment.destroy
      flash[:danger] = "Comment was successfully deleted"
      redirect_to :back
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :user_name, :article_id)
    end
  end
