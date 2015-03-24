class AlertsController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :alert_params

  def show
    respond_with @alert
  end

  def index
    @alerts = Alert.all
    respond_with @alerts
  end

  def create
    @alert = Alert.create(alert_params)
    respond_with @alert
  end

  def update
    @alert.update_attributes(alert_params)
    respond_with @alert
  end

  def destroy
    @alert.destroy
    respond_with @alert
  end


  private

  def alert_params
    params.require(:alert).permit(
      :id, :type, :description, :cause, :pending
      )
  end
end