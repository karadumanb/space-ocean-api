# class GamesController < ApplicationController
#     before_action :set_game, only: [:show, :destroy]
#     before_action :require_user, except: [:index, :show]

#     def index
#       @games = Game.paginate(page: params[:page], per_page: 5)
#     end

#     def new
#       @games = Game.new
#     end

#     def create
#     end

#     def show
#     end

#     def destroy
#       @games.destroy
#       flash[:danger] = "Game was successfully deleted"
#       redirect_to games_path
#     end

#     private

#     def set_game
#       @games = Game.find(params[:id])
#     end
# end
