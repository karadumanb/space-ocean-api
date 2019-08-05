class Api::ApplicationController < ActionController::Base
    include Pundit
  
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  
    # before_action :authenticate
    # before_bugsnag_notify :add_user_info_to_bugsnag
  
    protected
  
    def render_not_found_response(exception)
      render json: { error: exception.message }, status: :not_found
    end
  
    # Validates the token and user and sets the @current_user scope
    # def authenticate
    #   return invalid_authentication if invalid_payload?
    #   invalid_authentication unless current_user
    # end
  
    # Returns 401 response. To handle malformed / invalid requests.
    # def invalid_authentication
    #   render json: { error: :invalid_request }, status: :unauthorized
    # end
  
    def includes
      params[:includes]&.map(&:to_sym) || []
    end
  
    def relationships
      params[:relationships]&.map(&:to_sym) || []
    end
  
    def serializer_params
      Hash[(relationships + includes).uniq.map { |v| [v, true] }]
    end
  
    def sort_params
      SortParams.sorted_fields(params[:sort])
    end
  
    def filter_params
      raise NotImplementedError
    end
  
    def serialize_errors(record)
      {}.tap do |error|
        record.errors.details.map do |_, details|
          details.map do |error_detail|
            # FIX: this line override old previous values, so we'll get only the last one
            error[:error] = error_detail[:error]
          end
        end
      end
    end
  
    def add_user_info_to_bugsnag(report)
      if Current.user.present?
        report.user = {
          id:    Current.user.id,
          email: Current.user.email
        }
      end
    end
  
    private
  
    # Deconstructs the Authorization header and decodes the JWT token.
    def payload
      @_payload ||= begin
        auth_header = request.headers['Authorization']
        token       = auth_header.split(' ').last
        JsonWebToken.decode(token)
      rescue
        nil
      end
    end
  
    # Sets the @current_user with the user_id from payload
    def current_user
      @_current_user ||= User.find_by(id: payload.present? ? payload[0]['user_id'] : 1).tap do |user|
        User.current      = user
        session[:user_id] = user.id
      end
    end
  
    def invalid_payload?
      payload.blank? || !JsonWebToken.valid_payload(payload.first)
    end
  
    def authorize!(resource)
      "#{resource.class}Policy".safe_constantize.new(User.first, resource).can?(params[:action]) do |message|
        render json: { error: message }, status: :forbidden
      end
    end
  
    def policy(scope)
      super([:user, scope])
    end
  
    def policy_scope(scope)
      super([:user, scope])
    end

end
