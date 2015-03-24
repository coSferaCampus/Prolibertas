require 'rails_helper'

RSpec.describe AlertsController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = FactoryGirl.attributes_for(:alert).keys

  before :all do
    @user = FactoryGirl.create(:user)
    @person = FactoryGirl.create(:person)
    
    # Para todos los tests
    @model = Alert

    # Para el test de show
    @resource = FactoryGirl.create(:alert)

    # Para el test de index
    @first_page_resources = Alert.all

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:alert)

    # Para el test de update
    @update_params = FactoryGirl.attributes_for(:alert_update)
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes
end
