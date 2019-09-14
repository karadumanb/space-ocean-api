class Api::V1::PuzzlesController < ApplicationController
    before_action :set_puzzle, only: [:show, :update, :destroy]

    def index
      @puzzles = Puzzle.all
      render json: @puzzles
    end

    def show
      render json: @puzzle
    end

    def create
      @puzzle = Puzzle.new(puzzle_params)

      if @puzzle.save
        render json: @puzzle, status: :created, location: @puzzle
      else
        render json: @puzzle.errors, status: :unprocessable_entity
      end
    end

    def update
      if @puzzle.update(puzzle_params)
        render json: @puzzle
      else
        render json: @puzzle.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @puzzle.destroy
    end

    def random_gen
      @puzzle = Puzzle.order("RANDOM()").first
      render json: @puzzle
    end

    private
      def set_puzzle
        @puzzle = Puzzle.find(params[:id])
      end

      def puzzle_params
        params.require(:puzzle).permit(:times_played, :rating)
      end
end
