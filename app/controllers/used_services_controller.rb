class UsedServicesController < ApplicationController
  respond_to :json

  def show
    @used_service = UsedService.find(params[:id])
    respond_with @used_service
  end

  def create
    @used_service = UsedService.create(used_service_params)
    respond_with @used_service
  end

  def destroy
    @used_service= UsedService.find(params[:id])
    @used_service.destroy
    respond_with @used_service
  end

  private

  def used_service_params
    params.require(:used_service).permit(
      :person_id, :service_id
      )
  end
end
