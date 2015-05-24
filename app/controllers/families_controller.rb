class FamiliesController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :family_params

  def show
    respond_with @family
  end

  def index
    @families = Family.all
    respond_with @families
  end

  def create
    @family = Family.create(family_params)
    respond_with @family
  end

  def update
    @family.update_attributes(family_params)
    respond_with @family
  end

  def destroy
    @family.destroy
    respond_with @family
  end

  private

  def family_params
    params.require(:family).permit(
      :id, :name, :surname, :origin, :menu, :genre, :phone, :adults, :children, :center, :socialworker, :type_of_income, :amount_of_income, :address_type, :address, :assistance, :nif
    )
  end
end
