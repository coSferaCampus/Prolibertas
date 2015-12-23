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

  def paginate
    if not @scope.empty?
      @total_scope = @scope.size
      @scope = @scope.page( params[:page] ).per(
        params[:page_size] || Kaminari.config.default_per_page)
    end
  end

  def max_pages
    if params[:page]
      (@scope.length / (params[:page_size] || Kaminari.config.default_per_page).to_f).ceil
    end
  end

  def param_regex(param_name)
    Regexp.new(Regexp.escape("#{I18n.transliterate(params[param_name])}".strip.squeeze(' ')), 'i')
  end

  private

  def render_exception(status)
    respond_to do |format|
      format.all { render nothing: true, status: status }
    end
  end
end
