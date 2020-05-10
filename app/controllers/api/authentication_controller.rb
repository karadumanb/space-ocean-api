class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :authenticate, except: [:logout, :login_session]
  skip_before_action(:verify_authenticity_token, only: [:login])

  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    unless user && user.authenticated?(params[:password])
      render json: { error: 'Wrong email or password' }, status: :unauthorized and return
    end
    sign_in(user) do |status|
      if status.success?
        render json: ::UserSerializer.new(user), status: :ok
      else
        render json: { error: 'Access denied' }, status: :unauthorized
      end
    end
  end

  def login_session
    if current_user.present?
      render json: ::UserSerializer.new(current_user), status: :ok
    else
      render json: { error: 'Access denied' }, status: :unauthorized
    end
  end

  def logout
    reset_session
    sign_out
    head :ok
  end
end
