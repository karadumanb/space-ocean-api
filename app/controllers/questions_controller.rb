class QuestionsController < ApplicationController
    before_action :set_question, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]

    def index
      @questions = Question.paginate(page: params[:page], per_page: 5)
    end

    def new
      @question = Question.new
    end

    def edit
    end

    def create
      @question = Question.new(question_params)
      if @question.save
        flash[:success] = "Question was created successfully"
        redirect_to question_path(@question)
      else
        render 'new'
      end
    end

    def update
      if @question.update(question_params)
        flash[:success] = "Question was successfully updated"
        redirect_to question_path(@question)
      else
        render 'edit'
      end
    end

    def show
    end

    def destroy
      @question.destroy
      flash[:danger] = "Question was successfully deleted"
      redirect_to questions_path
    end

    private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:body, :answer, :difficulty)
    end
end
