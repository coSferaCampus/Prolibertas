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

  def individual_report
    @individual_report = UsedService.where( family_id: params[:id] ).desc(:created_at)

     respond_with @individual_report.to_json
  end

  private

  def family_params
    params.require(:family).permit(
      :id, :name, :surname, :origin, :menu, :phone, :adults, :children, :birthchildren, :center, :socialworker, :type_of_income, :amount_of_income, :address, :assistance, :identifier, :from, :to, :id_type, :zts, :social_tlf, :muslim, :ropero_date, :ropero_time
#      , :address_type
    )
  end
end
