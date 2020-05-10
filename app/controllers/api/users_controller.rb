class Api::UsersController < Api::ApplicationController
  before_action :set_user, only: [:show]

  def show
    if @user
      render json: UserSerializer.new(@user), status: :ok
    else
      render json: serialize_errors(@user), status: :not_found
    end
  end
  private

  def set_user
    @user = User.find(params[:id])
  end
end

