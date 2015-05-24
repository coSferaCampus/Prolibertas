require 'rails_helper'

RSpec.describe FamiliesController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create]
  json_attributes = FactoryGirl.attributes_for(:family).keys

  before :all do
    @user = FactoryGirl.create(:director)

    # Para todos los tests
    @model = Family

    # Para el test de show
    @resource = FactoryGirl.create(:family)

    # Para el test de index
    @first_page_resources = Family.all

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:family)

    # Para el test de update
    @update_params = FactoryGirl.attributes_for(:family_update)
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes
end
