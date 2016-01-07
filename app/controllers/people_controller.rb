class PeopleController < ApplicationController
  before_action :determine_scope, only: :index
  before_action :set_total,       only: :index
  before_action :filter_scope,    only: :index
  before_action :paginate,        only: :index

  respond_to :json
  load_and_authorize_resource param_method: :person_params

  def index
    $selected_day = params[:selected_day]
    $day          = params[:selected_day] ? params[:selected_day].to_time : Date.today
    @people       = @scope

    respond_with @people
  end

  def show
    respond_with @person
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
      autores       = @autors.uniq

      autores.each_with_index        { |v, i| autors        += i == 0 ? v : ", " + v }
      @service_names.each_with_index { |v, i| service_names += i == 0 ? v : ", " + v }

      @individual_report << { date: date, autors: autors, services: service_names }
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

  # Determine the scope of the request
  def determine_scope
    @scope = Person.asc(:surname_normalized)
  end

  def set_total
    $total_people = @scope.size
  end

  # Determine the filters of the index action
  def filter_scope
    [:surname, :origin, :identifier, :spanish].each do |t|
      send("filter_by_#{t}") if params[t].present?
    end
  end

  def filter_by_surname
    if params[:surname]
      @scope = @scope.where(surname_normalized: param_regex(:surname))
    end
  end

  def filter_by_origin
    if params[:origin]
      @scope = @scope.where(origin_normalized: param_regex(:origin))
    end
  end

  def filter_by_identifier
    if params[:identifier]
      @scope = @scope.where(identifier_normalized: param_regex(:identifier))
    end
  end

  def filter_by_spanish
    if params[:spanish] == "true"
      @scope = @scope.where(origin: "España")
    elsif params[:spanish] == "false"
      @scope = @scope.where(:origin.ne => "España")
    end
  end
end
