require 'rails_helper'

RSpec.describe SandwichesController, type: :controller do
  set_content_type 'application/json'

  options = [:create, :update]
  json_attributes = FactoryGirl.attributes_for(:sandwich).keys

  before :all do
    @user = FactoryGirl.create(:director)

    # Para todos los tests
    @model = Sandwich
    @resource = FactoryGirl.create(:sandwich)

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:sandwich)

    # Para el test de update
    @update_params = FactoryGirl.attributes_for(:sandwich_update)
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes
end
