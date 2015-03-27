class HistoriesController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :history_params

  def show
    respond_with @history
  end

  def index
    @histories = Person.find(params[:person_id]).histories
    respond_with @histories
  end

  def create
    @history = Person.find(params[:person_id]).histories.create(history_params)
    respond_with @history
  end

  def update
    @history.update_attributes(history_params)
    respond_with @history
  end

  def destroy
    @history.destroy
    respond_with @history
  end


  private

  def history_params
    params.require(:history).permit(
      :description, :liabilities, :date, :time, :newdate, :newtime, :file
      )
  end
end