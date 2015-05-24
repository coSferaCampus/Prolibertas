require 'rails_helper'

RSpec.describe ServicesController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :destroy]
  json_attributes = FactoryGirl.attributes_for(:service).keys


  before :all do
    @user = FactoryGirl.create(:director)

    # Para todos los tests
    @model = Service

    # Para el test de show
    @resource = FactoryGirl.create(:service)

    # Para el test de index
    @first_page_resources = Service.all

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:service)

    # Para el test de update
    @update_params = {name: "prueba", primary: false}

  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes

end
