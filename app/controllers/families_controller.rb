class FamiliesController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :family_params

  def index
    $selected_day = params[:selected_day]
    @families = Family.all

    if params[:kitchen]
      @families = @families.where(:from.lte => $selected_day, :to.gte => $selected_day)
    end

    respond_with @families
  end

  def show
    respond_with @family
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
    @individual_report = []
    dates              = []

    services = UsedService.where( family_id: params[:id] ).desc(:created_at)

    services.each { |service| dates << service.created_at }

    dates.uniq!
    dates.each do |date|
      @autors        = []
      @service_names = []

      services.where(created_at: date).each do |x|
        @autors << x.created_by.full_name
        @service_names << x.service.name
      end

      date          = date.to_s.split('-').reverse.join('/')
      autors        = ""
      service_names = ""
      autores       = @autors.uniq

      autores.each_with_index        { |v, i| autors        += i == 0 ? v : ", " + v }
      @service_names.each_with_index { |v, i| service_names += i == 0 ? v : ", " + v }

      @individual_report << { date: date, autors: autors, services: service_names }
    end

     respond_with @individual_report.to_json
  end

  private

  def family_params
    params.require(:family).permit(
      :id, :name, :surname, :origin, :menu, :phone, :adults, :children, :birthchildren, :center,
      :socialworker, :type_of_income, :amount_of_income, :address, :assistance, :identifier, :from,
      :to, :id_type, :zts, :social_tlf, :muslim, :ropero_date, :ropero_time, :city
#      , :address_type
    )
  end
end
