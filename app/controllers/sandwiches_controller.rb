class SandwichesController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :sandwich_params

  def create
    @sandwich = Sandwich.find_or_initialize_by(:created_at => params[:created_at])
    @sandwich.amount = params[:amount]
    @sandwich.save
    respond_with @sandwich
  end

  private

  def sandwich_params
    params.require(:sandwich).permit(:id, :created_at, :amount)
  end
end
