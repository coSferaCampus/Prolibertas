class ServicesController < ApplicationController
  respond_to :json

  def show
    @service = Service.find(params[:id])
    authorize! :show, @service
    respond_with @service
  end

  def index
    @services = Service.all
    authorize! :index, @services
    respond_with @services
  end

end
