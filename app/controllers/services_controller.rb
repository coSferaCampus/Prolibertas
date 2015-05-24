class ServicesController < ApplicationController
  respond_to :json

  def show
    @service = Service.find(params[:id])
    respond_with @service
  end

  def create
    @service = Service.create(service_params)
    respond_with @service
  end

  def index
    @services = Service.all
    respond_with @services
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    respond_with @service
  end

  private

  def service_params
    params.require(:service).permit(:id, :name, :primary)
  end
end
