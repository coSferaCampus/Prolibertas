class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied, with: :render_403
  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_404
  rescue_from ActionController::UnknownFormat, with: :render_406

  protected

  def render_403(exception)
    render_exception :forbidden
  end

  def render_404(exception)
    render_exception :not_found
  end

  def render_406(exception)
    render_exception :not_acceptable
  end

  private

  def render_exception(status)
    respond_to do |format|
      format.all { render nothing: true, status: status }
    end
  end
end
