class PeopleController < ApplicationController
  respond_to :json

  def show
    @person = Person.find(params[:id])
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
    @person = Person.find(params[:id])
    @person.update_attributes(person_params)
    respond_with @person
  end


  private

  def person_params
    params.require(:person).permit(
      :id, :name, :surname, :origin, :genre, :phone, :assistance, :home, :family_status, :health_status, :birth, :nif, :social_services, :menu, :income, :address, :contact_family, :notes
      )
  end

end
