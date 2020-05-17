class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :authenticate, only: [:login, :sign_up]
  skip_before_action :verify_authenticity_token, only: [:login, :sign_up]

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

  def sign_up
    Wf.new
      .chain(user: :user) { RegistrationService.new(registration_params) }
      .chain { |outflow|
        sign_in(outflow.user) do |status|
          if status.success?
            head :ok
          else
            render json: { error: 'Access denied' }, status: :unauthorized
          end
        end
      }
      .on_dam { |errors| render json: { errors: errors }, status: :bad_request }
  end

  def logout
    reset_session
    sign_out
    head :ok
  end

  private
  def registration_params
    params.permit(:email, :first_name, :last_name, :tel, :password, :role)
  end
end
