class PeopleController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :person_params

  def show
    respond_with @person
  end

  def index
    $selected_day = params[:selected_day]
    @people = Person.all
    respond_with @people
  end

  def create
    @person = Person.create(person_params)
    respond_with @person
  end

  def update
    @person.update_attributes(person_params)
    respond_with @person
  end

  def destroy
    @person.destroy
    respond_with @person
  end

  def individual_report
    @individual_report = []
    dates              = []

    services = UsedService.where( person_id: params[:id] ).desc(:created_at)

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

      @autors.uniq!.each_with_index  { |v, i| autors        += i == 0 ? v : ", " + v }
      @service_names.each_with_index { |v, i| service_names += i == 0 ? v : ", " + v }

      @individual_report << { "date": date, "autors": autors, "services": service_names }
    end

     respond_with @individual_report.to_json
  end

  private

  def person_params
    params.require(:person).permit(
      :id, :name, :surname, :origin, :genre, :phone, :assistance, :family_status, :health_status,
      :birth, :social_services, :menu, :income, :address, :contact_family, :notes, :documentation,
      :address_type, :city, :residence, :have_income, :entry, :output, :zts, :id_type, :identifier,
      :muslim)
  end
end
