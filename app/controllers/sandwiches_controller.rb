class SandwichesController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :sandwich_params

  def create
    @sandwich = Sandwich.find_or_initialize_by(:created_at => params[:created_at])
    @sandwich.amount = params[:amount]
    @sandwich.save
    respond_with @sandwich
  end

  def show
    if params[:selected_day]
      date = params[:selected_day].to_datetime
      @sandwich = Sandwich.where(:created_at.gte => date, :created_at.lt => date + 1.day).first
      @amt = @sandwich? @sandwich.amount : 0
      respond_with @amt
    end
  end

  private

  def sandwich_params
    params.require(:sandwich).permit(:id, :created_at, :amount)
  end
end
