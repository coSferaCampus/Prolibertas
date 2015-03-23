require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = FactoryGirl.attributes_for(:person).keys

  before :all do
    @user = FactoryGirl.create(:user)
    # Para todos los tests
    @model = Person

    # Para el test de show
    @resource = FactoryGirl.create(:person)

    # Para el test de index
    @first_page_resources = Person.all

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:person)

    # Para el test de update
    @update_params = FactoryGirl.attributes_for(:person_update)
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes
end
