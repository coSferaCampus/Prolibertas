require 'rails_helper'

RSpec.describe ServicesController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index]
  json_attributes = FactoryGirl.attributes_for(:service).keys


  before :all do
    @user = FactoryGirl.create(:user)

    # Para todos los tests
    @model = Service

    # Para el test de show
    @resource = FactoryGirl.create(:service)

    # Para el test de index
    @first_page_resources = Service.all

  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes

end
