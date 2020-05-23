class Api::UsersController < Api::ApplicationController
  skip_before_action :authenticate, only: [:show]
  before_action :set_user, only: [:show]

  def show
    if @user
      render json: UserSerializer.new(@user), status: :ok
    else
      render json: serialize_errors(@user), status: :not_found
    end
  end
  private
  def contains_only_numberic?(string)
    string.match(/\D/).blank?
  end

  def set_user
    identifier = params[:id]
    @user =contains_only_numberic?(identifier) ? User.find(identifier) : User.find_by(username: identifier)
  end
end

