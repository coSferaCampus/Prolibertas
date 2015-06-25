class SandwichesController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :sandwich_params

  def create
    @sandwich = Sandwich.create(sandwich_params)
    respond_with @sandwich
  end

  def update
    @sandwich.update_attributes(sandwich_params)
    respond_with @sandwich
  end

  private

  def sandwich_params
    params.require(:sandwich).permit(:id, :created_at, :amount)
  end
end
