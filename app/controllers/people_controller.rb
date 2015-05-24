class PeopleController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :person_params

  def show
    respond_with @person
  end

  def index
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

  private

  def person_params
    params.require(:person).permit(
      :id, :name, :surname, :origin, :genre, :phone, :assistance, :family_status, :health_status, :birth, :nif, :social_services, :menu, :income, :address, :contact_family, :notes, :documentation, :address_type, :city, :residence, :have_income
      )
  end
end
