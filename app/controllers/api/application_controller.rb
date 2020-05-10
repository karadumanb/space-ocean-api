class Api::ApplicationController < ActionController::Base
  include Clearance::Controller
  include Xsrfable
  include Pundit

  protect_from_forgery(with: :exception)

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    set_xsrf_cookie

    render json: { error: 'Access not granted' }, status: 422
  end

  before_action :authenticate

  # before_action :authenticate
  # before_bugsnag_notify :add_user_info_to_bugsnag

  protected
  def authenticate
    return invalid_authentication unless current_user.present?
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: { error: 'Access not granted' }, status: :unauthorized
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

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
    { errors: record.errors.messages }
  end

  def add_user_info_to_bugsnag(report)
    if Current.user.present?
      report.user = {
        id:    Current.user.id,
        email: Current.user.email
      }
    end
  end

  def page_param
    params[:page] ? params[:page] : 1
  end

  def per_page_param
    params[:per_page] ? params[:per_page] : 10
  end

  def pagination_meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
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
