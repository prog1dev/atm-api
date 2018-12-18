class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  around_action :process_errors
  protect_from_forgery with: :null_session

  private

  def process_errors
    yield
  rescue ActiveRecord::RecordNotFound, ActionController::RoutingError, AbstractController::ActionNotFound => e
    render json: { error: e.message, status: :not_found }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message, status: :unprocessable_entity }, status: :unprocessable_entity
  rescue ActionController::InvalidAuthenticityToken, ActionController::InvalidCrossOriginRequest => e
    render json: { error: e.message, status: :unprocessable_entity }, status: :unprocessable_entity
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors, status: :unprocessable_entity }, status: :unprocessable_entity
  rescue ActionController::MethodNotAllowed, ActionController::UnknownHttpMethod => e
    render json: { error: e.message, status: :method_not_allowed }, status: :method_not_allowed
  rescue ActionController::NotImplemented => e
    render json: { error: e.message, status: :not_implemented }, status: :not_implemented
  rescue ActionController::UnknownFormat => e
    render json: { error: e.message, status: :not_acceptable }, status: :not_acceptable
  rescue ActionController::BadRequest, ActionController::ParameterMissing => e
    render json: { error: e.message, status: :bad_request }, status: :bad_request
  rescue StandardError => e
    render json: { error: e.message, status: :internal_server_error }, status: :internal_server_error
  end
end
