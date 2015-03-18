class ServicesController < ApplicationController
  respond_to :json

  def show
    @service = Service.find(params[:id])
    respond_with @service
  end

  def index
    @services = Service.all
    respond_with @services
  end

end
